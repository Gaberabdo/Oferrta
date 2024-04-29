import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sell_4_u/Features/Auth-feature/manger/model/user_model.dart';
import 'package:sell_4_u/Features/Home-feature/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sell_4_u/Features/Home-feature/models/product_model.dart';
import 'package:sell_4_u/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constant.dart';
import '../../../../core/helper/cache/cache_helper.dart';
import 'feeds_state.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FeedsCubit extends Cubit<FeedsState> {
  FeedsCubit() : super(FeedsInitial());

  static FeedsCubit get(context) => BlocProvider.of(context);

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  List<CategoryModel> catModel = [];
  List<String> catModelIdes = [];
  List<String> catModelDetailsIdes = [];

  bool isGetCategoryLoading = false;

  Future<void> getCategory() async {
    emit(GetCategoryLoading());
    fireStore.collection("categories").get().then((event) {
      catModel.clear();
      catModelIdes.clear();
      for (var element in event.docs) {
        catModel.add(CategoryModel.fromJson(element.data()));
        catModelIdes.add(element.id);
      }
      isGetCategoryLoading = true;
      emit(GetCategorySuccess());
    }).catchError((handleError) {
      emit(GetCategoryError());
    });
  }

  List<ProductModel> getCategoryDetailsModel = [];

  Future<void> getCategoryDetails(String id) async {
    emit(GetCategoryLoading());
    fireStore
        .collection("categories")
        .doc(id)
        .collection('products')
        .get()
        .then((event) {
      getCategoryDetailsModel.clear();
      catModelDetailsIdes.clear();
      for (var element in event.docs) {
        getCategoryDetailsModel.add(ProductModel.fromJson(element.data()));
        catModelDetailsIdes.add(element.id);
      }
      emit(GetCategoryDetailsSuccess());
    }).catchError((handleError) {
      emit(GetCategoryError());
    });
  }

  Future<void> deleteCategory(String id) async {
    emit(GetCategoryLoading());
    fireStore.collection("categories").doc(id).delete().then((value) {
      emit(GetCategoryDetailsSuccess());
    }).catchError((handleError) {
      emit(GetCategoryError());
    });
  }

  List<ProductModel> mostPopularModel = [];
  List<String> mostPopularIdes = [];

  Future<void> mostPopular() async {
    emit(GetMostPopularLoading());
    fireStore.collection("products").snapshots().listen((event) {
      mostPopularModel.clear();
      mostPopularIdes.clear();
      for (var element in event.docs) {
        mostPopularModel.add(ProductModel.fromJson(element.data()));
        mostPopularIdes.add(element.id);
      }
      emit(GetMostPopularSuccess());
    }).onError((handleError) {
      emit(GetMostPopularError());
    });
  }

  Future<void> deleteProduct({
    required String id,
    required String catId,
    required String catProId,
  }) async {
    print(id);
    print(catId);
    emit(DeleteProductLoading());
    fireStore.collection("products").doc(id).delete().then((value) {
      fireStore
          .collection('categories')
          .doc(catId)
          .collection("products")
          .doc(catProId)
          .delete()
          .then((value) {
        emit(DeleteProductDetailsSuccess());
      }).catchError((handleError) {
        emit(DeleteProductError());
      });
      emit(DeleteProductDetailsSuccess());
    }).catchError((handleError) {
      emit(DeleteProductError());
    });
  }

  UserModel? userModel;

  Future<void> getUserData({required String id}) async {
    emit(GetMostPopularLoading());
    fireStore.collection("users").doc(id).snapshots().listen((event) {
      userModel = UserModel.fromJson(event.data());

      emit(GetUserSuccess());
    }).onError((handleError) {
      emit(GetUserError());
    });
  }

  ProductModel modelDetails = ProductModel();

  Future<void> getDetailsProData({required String id}) async {
    emit(GetMostPopularLoading());
    fireStore.collection("products").doc(id).snapshots().listen((event) {
      modelDetails = ProductModel.fromJson(event.data()!);
      emit(GetUserSuccess());
    }).onError((handleError) {
      emit(GetUserError());
    });
  }

  void makePhoneCall({required String phone}) async {
    final url = Uri.parse('tel:$phone');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void openWhatsApp({required String phone}) async {
    final url = Uri.parse('https://wa.me/$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.inAppWebView);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<File> imageList = [];
  List<String> postListOfImage = [];

  Future<void> pickImages() async {
    final FileUploadInputElement input = html.FileUploadInputElement();
    input.accept = 'image/*'; // accept only image files

    // Trigger file picker dialog
    input.click();

    // Listen for changes in the file selection
    input.onChange.listen((event) {
      final fileList = input.files;
      if (fileList!.isNotEmpty) {
        final file = fileList[0];
        imageList.add(file);
        emit(ImageUploadSuccess());
      } else {
        emit(ImageUploadFailed());
      }
    });
  }

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
        imageList.add(file);
        emit(ImageUploadSuccess());
      } else {
        emit(ImageUploadFailed());
      }
    });
  }

  Future<void> uploadImages({
    required String uId,
  }) async {
    isLoading = true;
    emit(ImageUploadToFireLoading());

    List<File> imagesToRemove = [];

    for (var image in imageList) {
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();

        Reference storageReference =
            FirebaseStorage.instance.ref().child('product/$fileName');

        // Read the file as bytes
        final reader = html.FileReader();
        reader.readAsArrayBuffer(image);
        await reader.onLoad.first;
        final buffer = reader.result as Uint8List;

        // Convert bytes to Blob
        final blob = html.Blob([buffer]);

        UploadTask uploadTask = storageReference.putBlob(blob);
        TaskSnapshot taskSnapshot = await uploadTask;
        String imageUrl = await taskSnapshot.ref.getDownloadURL();
        postListOfImage.add(imageUrl);
        emit(ImageUploadToFireSuccess());
      } catch (e) {
        print('Error uploading image: $e');
        emit(ImageRemovedFailed());
      }
      imagesToRemove.add(image);
    }

    for (var image in imagesToRemove) {
      imageList.remove(image);
    }

    emit(ImageRemovedFailed());

    if (imageList.isEmpty) {
      requestPostToFire(uId: uId);
      emit(ImageUploadSuccess());
    }
  }

  Future<void> requestPostToFire({
    required String uId,
  }) async {
    print(postListOfImage);
    String formattedDate = DateFormat('E MMM d y HH:mm:ss \'GMT\'Z (z)', 'en')
        .format(DateTime.now());
    ProductModel model = ProductModel(
      cat: catController.text,
      images: postListOfImage,
      description: descController.text,
      details: detailController.text,
      lan: longitude,
      lat: latitude,
      location: currentAddress,
      price: priceController.text,
      reasonOfOffer: reasonController.text,
      time: formattedDate,
      uId: uId,
      numberOfDay: 30,
      view: 0,
    );
    print(model.toMap());

    emit(RequestPostToFireLoading());
    Future.delayed(const Duration(seconds: 2), () async {
      await fireStore.collection('products').add(model.toMap()).then((event) {
        fireStore
            .collection('users')
            .doc(uId)
            .collection('products')
            .doc(event.id)
            .set(model.toMap())
            .then((value) {
          print(model.toMap());

          fireStore
              .collection('categories')
              .doc(catIdString!)
              .collection('products')
              .doc(event.id)
              .set(model.toMap())
              .then((value) {
            print(model.toMap());

            isLoading = false;
            sendNot();
            emit(RequestPostToFireSuccess());
          }).catchError((onError) {
            print('product to cat $onError');
            emit(RequestPostToFireError());
          });
        }).catchError((value) {
          print('product to user $value');
          emit(RequestPostToFireError());
        });
      }).catchError((onError) {
        print('product to product $onError');
        emit(RequestPostToFireError());
      });
    });
  }

  void deleteImage({
    required File value,
  }) {
    imageList.remove(value);
    emit(ImageUploadFailed());
  }

 // String catValueString =  S.of(context).selectCate;
  String? catIdString;

  void catValueStringCreate({
    required String value,
    required int index,
  }) {
    //catValueString = value;
    catController.text = value;
    catIdString = catModelIdes[index];
    print(catIdString);
    //print(catValueString);
    print(catController.text);
    emit(ImageUploadFailed());
  }

  double? latitude;
  double? longitude;
  Position? currentPosition;
  String? currentAddress;

  Future<void> getCurrentPosition(context) async {
    emit(GetLocationLoading());

    final hasPermission = await handleLocationPermission(context);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      latitude = position.latitude;
      longitude = position.longitude;
      print('${currentPosition}currentPosition');
      currentAddress = position.toString();
      locationController.text = currentAddress!;
      getAddressFromLocation(position);
      emit(GetLocationSuccess());
    }).catchError((e) {
      debugPrint(e);
      emit(GetLocationError());
    });
  }

  Future<String> getAddressFromLocation(Position position) async {
    try {
      List<Location> locations = await locationFromAddress(
        '${position.latitude}, ${position.longitude}',
      );

      if (locations.isNotEmpty) {
        Location firstLocation = locations.first;
        return '${firstLocation.latitude}, ${firstLocation.longitude}, ${firstLocation.timestamp}';
      } else {
        return 'Address not found';
      }
    } catch (e) {
      print('Error fetching address: $e');
      return 'Error fetching address';
    }
  }
  Future<bool> handleLocationPermission(context) async {
    emit(GetLocationLoading());
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      emit(GetLocationSuccess());
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(GetLocationError());

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  TextEditingController reasonController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController catController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool? isLoading;

  void updateValue({
    required dynamic value,
    required dynamic productId,
  }) {
    {
      fireStore.collection('products').doc(productId).update({
        "view": value + 1,
      });
      emit(GetLocationSuccess());
    }
  }

  void updateValueFav({
    required ProductModel value,
    required String productId,
  }) {
    if (isFav) {
      fireStore
          .collection('users')
          .doc(CacheHelper.getData(key: 'uId'))
          .collection('fave')
          .doc(productId)
          .set(value.toMap());
    } else {
      fireStore
          .collection('users')
          .doc(CacheHelper.getData(key: 'uId'))
          .collection('fave')
          .doc(productId)
          .delete();
    }

    emit(GetLocationSuccess());
  }

  bool isFav = false;

  void updateValueFavBool() {
    isFav = !isFav;
    emit(GetLocationSuccess());
  }

  Future<void> sendNot() async {
    final data = {
      'to': '/topics/Admin',
      'notification': {
        'body': 'Notification Form 4Sales',
        'title': 'Come to know what\'s new ads ',
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
}
