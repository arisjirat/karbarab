import 'package:flutter/foundation.dart';

class UserModel {
  final String id;
  final String username;
  final bool isGoogleAuth;
  final String tokenFCM;
  final String password;
  final String email;
  final String avatar;
  final String fullname;

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
