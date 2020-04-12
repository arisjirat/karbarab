import 'package:flutter/foundation.dart';

class UserModel {
  String id;
  String username;
  bool isGoogleAuth;
  String tokenFCM;
  String password;
  String email;
  String avatar;
  String fullname;

  UserModel({
    @required this.id,
    @required this.username,
    @required this.isGoogleAuth,
    @required this.tokenFCM,
    this.password,
    this.email,
    this.avatar,
    this.fullname,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    isGoogleAuth = json['isGoogleAuth'];
    tokenFCM = json['tokenFCM'];
    password = json['password'];
    email = json['email'];
    avatar = json['avatar'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['email'] = email;
    data['username'] = username;
    data['isGoogleAuth'] = isGoogleAuth;
    data['tokenFCM'] = tokenFCM;
    data['password'] = password;
    data['avatar'] = avatar;
    data['fullname'] = fullname;
    return data;
  }
}
