
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_4_u/Admin/Features/Subscriptions-Feature/manger/cubit/subscripation-states.dart';
import 'package:sell_4_u/Admin/Features/Subscriptions-Feature/manger/models/subscripation-model.dart';

class SubscripationCubit extends Cubit<SubscripationStates> {
  SubscripationCubit() : super(SubscripationInitialState());

  static SubscripationCubit get(context) => BlocProvider.of(context);
///add
  void addSubscription({
    required String name,
    required double price,
    required double discount,
  }) {
    var model = SubscripationModel(
      name: name,
      discount: discount,
      price: price,
    );

    FirebaseFirestore.instance.collection('subscripations').add(model.toMap())
        .then((docRef) {
      var id = docRef.id;
      model.id = id;

      FirebaseFirestore.instance.collection('subscripations').doc(id).set(model.toMap())
          .then((_) {
        emit(SubscripationAddedScussesState());
      })
          .catchError((error) {
        print("Failed to add subscription: $error");
        emit(SubscripationAddedErorrState());
      });
    })
        .catchError((error) {
      print("Failed to add subscription: $error");
      emit(SubscripationAddedErorrState());
    });
  }
///get
  List<SubscripationModel> subscriptions = [];
  Future<void> getSubscriptions() async{
    emit(SubscripationGetLoadinglState());
    FirebaseFirestore.instance.collection('subscripations').snapshots().listen((snapshot) {
      subscriptions=[];
snapshot.docs.forEach((element) {

  print('eeeeeeeeeeeeelement${element.data()}');
});
      for (var doc in snapshot.docs) {
        var data = doc.data();
        subscriptions.add(SubscripationModel.fromJson(data));
        print(subscriptions.length);
        print('lennnnnnnnnnthhhhhhhhhh');
      }
      emit(SubscripationGetScussesState());
    }, onError: (e) {
      print(e.toString());
      emit(SubscripationGetErorrState());
    });
  }
  /// update
  void updateSubscription({
     String? subscriptionId,
    required String name,
    required double price,
    required double discount,
  }) {
    var model = SubscripationModel(
      name: name,
      discount: discount,
      price: price,
      id: subscriptionId
    );

    FirebaseFirestore.instance.collection('subscripations').doc(subscriptionId).update(model.toMap()).then((value) {
      emit(SubscriptionUpdatedSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SubscriptionUpdatedErrorState());
    });
  }
  ///delete
  void deleteSubscription(String subscriptionId) {
    FirebaseFirestore.instance.collection('subscripations').doc(subscriptionId).delete()
        .then((value) {
      emit(SubscriptionDeletedSuccessState());
    })
        .catchError((error) {
      print("Failed to delete subscription: $error");
      emit(SubscriptionDeletedErrorState());
    });
  }
}

