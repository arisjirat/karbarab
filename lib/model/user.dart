library user;

import 'package:built_value/built_value.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  String get id;
  
  @nullable
  String get avatar;
  
  @nullable
  String get email;

  @nullable
  String get fullname;

  bool get isGoogleAuth;

  @nullable
  String get password;

  String get tokenFCM;

  String get username;

  factory User([void Function(UserBuilder) updates]) = _$User;
  User._();

}