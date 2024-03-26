import 'package:flutter/material.dart.';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      uId: json['uId'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'image': image,
        'uId': uId
      };
}
