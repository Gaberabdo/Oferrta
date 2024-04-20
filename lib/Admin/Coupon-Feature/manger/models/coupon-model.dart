import 'package:cloud_firestore/cloud_firestore.dart';

class CouponModel {
  String? name;
  String? username;
  String? id;
  double? price;
  int? numOfUses; // Changed type to int
  Timestamp? usedAt;

  CouponModel({
    this.name,
    this.price,
    this.numOfUses,
    this.usedAt,
    this.username,
    this.id,
  });

  CouponModel.fromJson(Map<String, dynamic>? json) {
    price = json!['price']?.toDouble() ?? 0.0; // Parse as double
    name = json['name'] ?? '';
    id = json['id'] ?? '';
    numOfUses = json['numOfUses'] ?? 0;
    usedAt = json['usedAt'] as Timestamp?; // Parse as Timestamp
    username = json['username'] ?? '';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'numOfUses': numOfUses,
      'usedAt': usedAt,
      'username': username,
      'id': id,
    };
  }
}
