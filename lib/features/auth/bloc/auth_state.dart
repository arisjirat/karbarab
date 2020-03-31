part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthState {}

class Authenticated extends AuthState {
  final String displayName;
  final String avatar;
  final String fullname;
  final bool isGoogleAuth;
  final int totalPoints;

  const Authenticated({
    @required this.displayName,
    @required this.avatar,
    @required this.isGoogleAuth,
    @required this.fullname,
    @required this.totalPoints,
  });

  @override
  List<Object> get props => [displayName, avatar, fullname, totalPoints];

  @override
  String toString() =>
      'Authenticated { displayName: $displayName, avatar: $avatar }';
}

class Unauthenticated extends AuthState {}
