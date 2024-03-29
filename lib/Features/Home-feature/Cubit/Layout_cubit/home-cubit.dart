import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_4_u/Features/Home-feature/view/screens/home/create_post.dart';
import 'package:sell_4_u/Features/Home-feature/view/screens/home/feeds_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sell_4_u/Features/Home-feature/view/screens/home/panner_cat.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/helper/cache/cache_helper.dart';
import '../../../Auth-feature/manger/model/user_model.dart';
import 'home-state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const FeedsScreen(),
    const BannerCat(),
    const CreatePost(),
    const Column(),
  ];
  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    emit(ChangeItemIndex());
  }
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  UserModel model = UserModel();

  Future<void> getUser() async {
    fireStore.collection('users')
        .doc(CacheHelper.getData(key: 'uId'))
        .snapshots()
        .listen((value) {
      model = UserModel.fromJson(value.data()!);
      emit(GetUserdataSuccess());
    }).onError((handleError) {
      emit(ErrorGetUserdata());
    });
    emit(LoadingGetUserdata());
  }
}
