import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-state.dart';
import 'package:sell_4_u/Features/Auth-feature/manger/model/user_model.dart';


class BlockUserCubit extends Cubit<BlockUserStates> {
  BlockUserCubit() : super(BlockInitialState());

  static BlockUserCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<UserModel> allUser = [];

  void getAllUserData() {
    emit(GetAllUserLoadingHomePageStates());
    FirebaseFirestore.instance.collection('users').snapshots().listen((value) {
      allUser.clear();
      for (var element in value.docs) {
        allUser.add(UserModel.fromJson(element.data()));
      }
      print(allUser.length);
      print('lenttttttttttttttttttth');
      emit(GetAllUserSuccessHomePageStates());
    }).onError((onError) {
      print(onError.toString());
      emit(GetAllUserErrorHomePageStates());
    });
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
  Duration difference=Duration();
  Future<bool> isBlockedForTwentyDays(String uId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(uId).get();
      if (!snapshot.exists) return false;

      Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;

      if (userData != null) {
        bool? blocked = userData['blocked'];
        Timestamp? blockTimestamp = userData['blockTimestamp'];

        if (blocked == true && blockTimestamp != null) {
           difference = Timestamp.now().toDate().difference(blockTimestamp.toDate());
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
  List<UserModel> searchList = [];

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
      searchList = users;
      print(searchList.length);
      print('searchhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      emit(UserSearchSuccess());
    } catch (e) {
      emit(UserSearchFailure());
    }
  }

}


