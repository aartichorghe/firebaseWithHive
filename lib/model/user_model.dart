import 'dart:core';
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  String address;

  @HiveField(4)
  String mobileNo;

  @HiveField(5)
  String profilePic;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.mobileNo,
    required this.profilePic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"] ?? '',
      email: json["email"] ?? '',
      address: json["address"] ?? '',
      mobileNo: json["mobileNo"] ?? '',
      profilePic: json["profilePic"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "address": address,
        "mobileNo": mobileNo,
        "profilePic": profilePic,
      };
}
