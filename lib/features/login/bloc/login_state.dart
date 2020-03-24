import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isSuccess;
  final bool isFailure;
  final bool isLoading;

  LoginState({
    @required this.isSuccess,
    @required this.isFailure,
    @required this.isLoading,
  });

  factory LoginState.empty() {
    return LoginState(
      isSuccess: false,
      isFailure: false,
      isLoading: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isSuccess: false,
      isFailure: false,
      isLoading: true,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isSuccess: false,
      isFailure: true,
      isLoading: false,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isSuccess: true,
      isFailure: false,
      isLoading: false,
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
    }''';
  }
}