import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sell_4_u/Features/setting/model/user_model.dart';

class EditMethod {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  getUserDetails() async {
    User currentuser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot = await users.doc(currentuser.uid).get();
    return UserModel.fromSnap(documentSnapshot);
  }
}
