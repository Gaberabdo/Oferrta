import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-state.dart';
import 'package:sell_4_u/Features/Auth-feature/manger/model/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

import '../../../../core/constant.dart';

class BlockUserCubit extends Cubit<BlockUserStates> {
  BlockUserCubit() : super(BlockInitialState());

  static BlockUserCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<UserModel> allUser = [];
  List<UserModel> filteredUser = [];
  UserModel activeUser = UserModel();

  void getAllUserData() {
    emit(GetAllUserLoadingHomePageStates());
    FirebaseFirestore.instance.collection('users').snapshots().listen((value) {
      allUser.clear();
      for (var element in value.docs) {
        if (element.id != "7QfP0PNO6qVWVKij4jJzVNCG9sj2") {
          allUser.add(UserModel.fromJson(element.data()));
        } else {
          activeUser = UserModel.fromJson(element.data());
        }
      }
      print(allUser.length);
      print('lenttttttttttttttttttth');
      emit(GetAllUserSuccessHomePageStates());
    }).onError((onError) {
      print(onError.toString());
      emit(GetAllUserErrorHomePageStates());
    });
  }

  void filterUsers(String query) {
    if (query.isEmpty) {
      filteredUser = List.from(allUser);
    } else {
      filteredUser = allUser.where(
        (user) {
          // Check if name, email, or phone number contains the query
          return user.name!.toLowerCase().contains(query.toLowerCase()) ||
              user.email!.toLowerCase().contains(query.toLowerCase()) ||
              user.phone!.toLowerCase().contains(query.toLowerCase());
        },
      ).toList();
    }
    // Emit state to update UI
    emit(FilterUsersSuccess());
  }

  Duration difference = Duration();

  Future<void> block(String uId, int? numberOfDays) async {
    try {
      DateTime now = DateTime.now(); // Get the current datetime
      DateTime unblockDateTime = now.add(Duration(days: numberOfDays!));

      Timestamp blockTimestamp = Timestamp.fromDate(unblockDateTime);

      await FirebaseFirestore.instance.collection('users').doc(uId).update({
        'blocked': true,
        'blockTimestamp': blockTimestamp,
      });

      isUserBlockedForNDays(
        uId,
        numberOfDays,
      );
    } catch (error) {
      print('Error blocking user: $error');
    }
  }

  Future<void> blockAlowes(
    String uId,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uId).update({
        'blocked': true,
        'blockTimestamp': null,
      });
    } catch (error) {
      print('Error blocking user: $error');
    }
  }

  Future<void> unblock(String uId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uId).update({
        'blocked': false,
        'blockTimestamp': null,
      });
    } catch (error) {
      // Handle error
      print('Error unblocking user: $error');
    }
  }

  Future<bool> isUserBlockedForNDays(String uId, int numberOfDays) async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uId).get();
      if (!snapshot.exists) return false;

      print(difference.inDays);
      Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;

      if (userData != null) {
        bool? blocked = userData['blocked'];
        Timestamp? blockTimestamp = userData['blockTimestamp'];

        if (blocked == true && blockTimestamp != null) {
          difference =
              blockTimestamp.toDate().difference(Timestamp.now().toDate());
          return difference.inDays >= numberOfDays;
        }

        print(difference.inDays);
      }
      return false;
    } catch (error) {
      // Handle error
      print('Error checking if user is blocked: $error');
      return false;
    }
  }

  ///search
  void searchUsers(String query) async {
    emit(UserSearchLoading());
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: query)
          .get();
      final users = snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      emit(UserSearchSuccess(users));
    } catch (e) {
      emit(UserSearchFailure());
    }
  }

  ///update user
  File? profileImage;

  bool isUpload = false;
  List<String> categoriesIdes = [];

  Future<void> pickImagesAdd() async {
    final FileUploadInputElement input = html.FileUploadInputElement();
    input.accept = 'image/*'; // accept only image files

    // Trigger file picker dialog
    input.click();

    // Listen for changes in the file selection
    input.onChange.listen((event) {
      final fileList = input.files;
      if (fileList!.isNotEmpty) {
        final file = fileList[0];
        profileImage = file;
        emit(ImageUploadSuccess());
      } else {
        emit(ImageUploadFailed());
      }
    });
  }

  Future<void> uploadCatImage({
    required String name,
    required String uid,
    required html.File profileImage,
  }) async {
    isUpload = true;
    emit(ImageUploadLoading());
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
      FirebaseStorage.instance.ref().child('catImage/$fileName');

      // Read the file as bytes
      final reader = html.FileReader();
      reader.readAsArrayBuffer(profileImage);
      await reader.onLoad.first;
      final buffer = reader.result as Uint8List;

      // Convert bytes to Blob
      final blob = html.Blob([buffer]);

      UploadTask uploadTask = storageReference.putBlob(blob);
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      updateCategory(
        id: uid,
        name: name,
        image: imageUrl,
      );
      isUpload = false;
      emit(ImageUploadSuccess());
    } catch (e) {
      isUpload = false;
      // Handle error
      print('Error uploading image: $e');
      emit(ImageUploadFailed());
    }
  }
  Future<void> updateCategory({
    required String id,
    required String name,
    required String image,
  }) async {
    isUpload = true;

    emit(UpdateLoadingUserDataState());
    firestore
        .collection("categories")
        .doc(id)
        .update({'categoryName': name, "image": image}).then((value) {
      isUpload = false;

      emit(UpdateSuccessUserDataState());
    }).catchError((handleError) {
      isUpload = false;

      emit(UpdateErrorUserDataState());
    });
  }

  Future<void> uploadImage({
    required String name,
    required String uid,
    required String phone,
  }) async {
    isUpload = true;
    emit(ImageUploadLoading());

    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
      FirebaseStorage.instance.ref().child('users/$fileName');

      // Read the file as bytes
      final reader = html.FileReader();
      reader.readAsArrayBuffer(profileImage!);
      await reader.onLoad.first;
      final buffer = reader.result as Uint8List;

      // Convert bytes to Blob
      final blob = html.Blob([buffer]);

      UploadTask uploadTask = storageReference.putBlob(blob);
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      updateUser(
        name: name,
        uid: uid,
        phone: phone,
        image: imageUrl,
      );
      isUpload = false;

      emit(ImageUploadSuccess());

    } on Exception catch (e) {
      isUpload = false;
      // Handle error
      print('Error uploading image: $e');
      emit(ImageUploadFailed());
    }
  }

  Future<void> updateUser({
    required String name,
    String? phone,
    required String image,
    required String uid,
  }) async {
    isUpload = true;

    emit(UpdateLoadingUserDataState());
    await firestore.collection('users').doc(uid).update({
      'name': name,
      'image': image,
      'phone': phone,
    }).then((value) {
      emit(UpdateSuccessUserDataState());
      isUpload = false;
    }).catchError((error) {
      isUpload = false;

      emit(UpdateErrorUserDataState());
    });
  }

  ///delete user
  Future<void> deleteUser({
    required String uid,
  }) async {
    try {
      emit(DeleteLoadingUserDataState());

      await firestore.collection('users').doc(uid).delete();

      emit(DeleteSuccessUserDataState());
    } catch (error) {
      emit(DeleteErrorUserDataState());

      print('Error deleting user data: $error');
    }
  }

  Future<void> sendNot({
    required String title,
    required String body,
  }) async {
    final data = {
      'to': '/topics/Admin',
      'notification': {
        'body': body,
        'title': title,
      }
    };

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=${Constant.notImage}'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://fcm.googleapis.com/fcm/send',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  // productId: productId,
  // uid: uid,
  // value: value,

  String? productId;
  String? uidOwner;
  dynamic value;
  int current = 0;
  UserModel? activeUserChat;

  void changeCurrent({
    required int index,
    String? productIdIN,
    String? uidOwnerIN,
    UserModel? model,
    dynamic? valueIN,
  }) {
    current = index;
    activeUserChat = model;
    productId = productIdIN;
    uidOwner = uidOwnerIN;
    value = valueIN;
    emit(ChangeCurrentState());
  }

  List<String> titles = [
    'Users',
    'Products',
    'Products Details',
    'Chats',
    'Subscriptions',
    'Coupon',
  ];
}
