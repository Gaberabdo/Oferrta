import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? token;
  String? platform;

  bool? blocked;
  Timestamp? blockTimestamp;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.blocked,
    this.token,
    this.platform,
    this.blockTimestamp,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'] ?? '';
    name = json['name'] ?? '';
    phone = json['phone'] ?? '';
    token = json['token'] ?? '';
    uId = json['uId'] ?? '';
    platform = json['platform'] ?? 'android';
    image = json['image'] ?? '';
    blocked = json['blocked'] ?? false;
    blockTimestamp = json['blockTimestamp'] != null ? json['blockTimestamp'] : null; // Convert to Timestamp if not null
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'platform': platform,
      'image': image,
      'blocked': blocked,
      'token': token,
      'blockTimestamp': blockTimestamp,
    };
  }
}
