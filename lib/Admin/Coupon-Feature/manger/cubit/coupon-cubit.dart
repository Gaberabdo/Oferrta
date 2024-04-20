import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/coupon-model.dart';
import 'coupon-states.dart';

class CouponCubit extends Cubit<CouponStates> {
  CouponCubit() : super(CouponInitialState());

  static CouponCubit get(context) => BlocProvider.of(context);

  ///add
  void addCoupons({
    required String name,
    required double price,
  }) {
    var model = CouponModel(name: name, price: price, numOfUses: 0);

    FirebaseFirestore.instance
        .collection('Coupons')
        .add(model.toMap())
        .then((docRef) {
      var id = docRef.id;
      model.id = id;

      FirebaseFirestore.instance
          .collection('Coupons')
          .doc(id)
          .set(model.toMap())
          .then((_) {
        emit(CouponAddedScussesState());
      }).catchError((error) {
        print("Failed to add subscription: $error");
        emit(CouponAddedErorrState());
      });
    }).catchError((error) {
      print("Failed to add subscription: $error");
      emit(CouponAddedErorrState());
    });
  }

  ///get
  List<CouponModel> coupons = [];

  Future<void> getCoupons() async {
    emit(CouponGetLoadinglState());
    FirebaseFirestore.instance.collection('Coupons').snapshots().listen(
        (snapshot) {
      coupons = [];
      snapshot.docs.forEach((element) {
        print('eeeeeeeeeeeeelement${element.data()}');
      });
      for (var doc in snapshot.docs) {
        var data = doc.data();
        coupons.add(CouponModel.fromJson(data));
        print(coupons.length);
        print('lennnnnnnnnnthhhhhhhhhh');
      }
      emit(CouponGetScussesState());
    }, onError: (e) {
      print(e.toString());
      emit(CouponGetErorrState());
    });
  }

  List<CouponModel> useruses = [];

  Future<void> getUserUses({
    required String id,
  }) async {
    emit(CouponGetLoadinglState());
    FirebaseFirestore.instance
        .collection('Coupons')
        .doc(id)
        .collection('Users')
        .snapshots()
        .listen((snapshot) {
      useruses = [];
      snapshot.docs.forEach((element) {
        print('eeeeeeeeeeeeelement${element.data()}');
      });
      for (var doc in snapshot.docs) {
        var data = doc.data();
        useruses.add(CouponModel.fromJson(data));
        print(useruses.length);
        print('lennnnnnnnnnthhhhhhhhhhuuuuuuuuuuuuuuuuu');
      }
      emit(CouponGetScussesState());
    }, onError: (e) {
      print(e.toString());
      emit(CouponGetErorrState());
    });
  }

  /// update
  void updateCoupons({
    String? subscriptionId,
    required String name,
    required double price,
  }) {
    var model = CouponModel(name: name, price: price, id: subscriptionId);

    FirebaseFirestore.instance
        .collection('Coupons')
        .doc(subscriptionId)
        .update(model.toMap())
        .then((value) {
      emit(SubscriptionUpdatedSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SubscriptionUpdatedErrorState());
    });
  }

  ///delete
  void deleteCoupons(String subscriptionId) {
    FirebaseFirestore.instance
        .collection('Coupons')
        .doc(subscriptionId)
        .delete()
        .then((value) {
      emit(SubscriptionDeletedSuccessState());
    }).catchError((error) {
      print("Failed to delete subscription: $error");
      emit(SubscriptionDeletedErrorState());
    });
  }
}
