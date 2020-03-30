import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginReset extends LoginEvent {}

class LoginWithGooglePressed extends LoginEvent {}

class LoginWithUsernamePassword extends LoginEvent {
  final String username;
  final String password;
  LoginWithUsernamePassword(
    this.username,
    this.password,
  );
}

class SignupWithUsername extends LoginEvent {
  final String username;
  final String password;
  SignupWithUsername(
    this.username,
    this.password,
  );
}
