import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-state.dart';
import 'package:sell_4_u/Features/Auth-feature/manger/model/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
      filteredUser = allUser.where((user) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    // Emit state to update UI
    emit(FilterUsersSuccess());
  }

  void block(String uId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uId).update({
        'blocked': true,
        'blockTimestamp': Timestamp.now(), // Set the current timestamp
      });
    } catch (error) {
      // Handle error
    }
  }

  void unblock(String uId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uId).update({
        'blocked': false,
        'blockTimestamp': null, // Reset the block timestamp
      });
    } catch (error) {
      // Handle error
    }
  }

  Duration difference = Duration();

  Future<bool> isBlockedForTwentyDays(String uId) async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uId).get();
      if (!snapshot.exists) return false;

      Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;

      if (userData != null) {
        bool? blocked = userData['blocked'];
        Timestamp? blockTimestamp = userData['blockTimestamp'];

        if (blocked == true && blockTimestamp != null) {
          difference =
              Timestamp.now().toDate().difference(blockTimestamp.toDate());
          return difference.inDays >= 20;
        }
      }
      return false;
    } catch (error) {
      print(error.toString());
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
    final picker = ImagePicker();
    final pickedImages = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImages != null) {
      profileImage = File(pickedImages.path);
      emit(ImageUploadSuccess());
    } else {
      emit(ImageUploadFailed());
    }
  }

  Future<void> uploadImage({
    required String name,
    required String uid,
    required String phone,
  }) async {
    isUpload = true;
    emit(ImageUploadLoading());
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('catImage/${Uri.file(profileImage!.path).pathSegments.last}');
    await ref.putFile(profileImage!).then((p0) {
      p0.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          uid: uid,
          phone: phone,
          image: value,
        );
        emit(ImageUploadSuccess());
      });
    });
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
  ];
}
