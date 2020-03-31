import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginReset extends LoginEvent {}

class ClearGoogle extends LoginEvent {}

class GoogleSync extends LoginEvent {}

class LoginWithGooglePressed extends LoginEvent {}
class SignupUsernameWithGoogle extends LoginEvent {
  final String username;
  SignupUsernameWithGoogle(
    this.username,
  );
}

class SignupWithUsername extends LoginEvent {
  final String username;
  SignupWithUsername(
    this.username,
  );
}