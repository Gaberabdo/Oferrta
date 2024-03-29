import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:sell_4_u/Features/Auth-feature/manger/model/user_model.dart';
import 'package:intl/intl.dart';
import 'package:sell_4_u/core/constant.dart';

import '../models/chat_model.dart';
import 'chat-states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(InitialChatPageStates());

  static ChatCubit get(context) => BlocProvider.of(context);
  File? chatImage;
  var picker = ImagePicker();

  List<UserModel> allUser = [];
  UserModel? allAdmin;

  Future<void> getChatImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  List<MessageModel> adminList = [];
  List<MessageModel> messages = [];

  void getMessage({required String receiveId}) {


    FirebaseFirestore.instance
        .collection('users')
        .doc('7QfP0PNO6qVWVKij4jJzVNCG9sj2')
        .collection('chat')
        .doc(receiveId)
        .collection('message')
        .orderBy('dateTime', descending: false)
        .snapshots()
        .listen((event) {

      messages.clear();
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }

      print(messages.length);
      emit(Sucessgetmessage());
    });
  }

  void removePostImage() {
    chatImage = null;

    emit(SocialRemovePostImageState());
  }

  void sendMessage({
    required String receiverId,
    required String text,
  }) {
    String formattedDate = DateFormat('E MMM d y HH:mm:ss \'GMT\'Z (z)', 'en').format(DateTime.now());
    MessageModel massageModel = MessageModel(
      message: text,
      senderId: "7QfP0PNO6qVWVKij4jJzVNCG9sj2",
      receiverId: receiverId,
      time: formattedDate,
      image: '',
    );

    // set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc('7QfP0PNO6qVWVKij4jJzVNCG9sj2')
        .collection('chat')
        .doc(receiverId)
        .collection('message')
        .add(massageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    // set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc("7QfP0PNO6qVWVKij4jJzVNCG9sj2")
        .collection('message')
        .add(massageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  void getMessageAdmin({required String receiveId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc('7QfP0PNO6qVWVKij4jJzVNCG9sj2')
        .collection('chat')
        .doc(receiveId)
        .collection('message')
        .orderBy('time')
        .snapshots()
        .listen((event) {
      adminList.clear();
      for (var element in event.docs) {
        adminList.add(MessageModel.fromJson(element.data()));
      }
      print(messages.length);
      emit(Sucessgetmessage());
    });
  }

  UserModel? userModel;

  void changeUser(UserModel model) {
    userModel = model;
    getMessage(receiveId: model.uId!);
    emit(ChangeUserState());
  }


}
