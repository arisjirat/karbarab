import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isSuccess;
  final bool isFailure;
  final bool isLoading;
  final bool errorIsGoogleAccountExist;
  final bool isUserExist;

  LoginState({
    @required this.isSuccess,
    @required this.isFailure,
    @required this.isLoading,
    this.errorIsGoogleAccountExist,
    this.isUserExist,
  });

  factory LoginState.empty() {
    return LoginState(
      isSuccess: false,
      isFailure: false,
      isLoading: false,
      errorIsGoogleAccountExist: false,
      isUserExist: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isSuccess: false,
      isFailure: false,
      isLoading: true,
      errorIsGoogleAccountExist: false,
      isUserExist: false,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isSuccess: false,
      isFailure: true,
      isLoading: false,
      errorIsGoogleAccountExist: false,
      isUserExist: false,
    );
  }

  factory LoginState.failureUserExist() {
    return LoginState(
      isSuccess: false,
      isFailure: false,
      isLoading: false,
      errorIsGoogleAccountExist: false,
      isUserExist: true,
    );
  }

  factory LoginState.failureGoogleAuthExist() {
    return LoginState(
      isSuccess: false,
      isFailure: false,
      isLoading: false,
      errorIsGoogleAccountExist: true,
      isUserExist: false,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isSuccess: true,
      isFailure: false,
      isLoading: false,
      errorIsGoogleAccountExist: false,
      isUserExist: false,
    );
  }

  LoginState update({
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isSuccess: false,
      isFailure: false,
    );
  }

  LoginState copyWith({
    bool isSuccess,
    bool isFailure,
    bool isLoading,
  }) {
    return LoginState(
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isLoading: $isLoading,
      errorIsGoogleAccountExist: $errorIsGoogleAccountExist,
      isUserExist: $isUserExist,
    }''';
  }
}