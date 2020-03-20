import 'package:flutter/foundation.dart';

class UserModel {
  final String id;
  final String email;
  final String avatar;
  final String fullname;
  final String name;

  UserModel({
    @required this.id,
    @required this.email,
    @required this.avatar,
    @required this.fullname,
    @required this.name,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['email'] = email;
    data['avatar'] = avatar;
    data['fullname'] = fullname;
    data['name'] = name;
    return data;
  }
}
