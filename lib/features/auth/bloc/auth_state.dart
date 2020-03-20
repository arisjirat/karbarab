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
  final int totalPoints;

  const Authenticated({@required this.displayName, @required this.avatar, @required this.fullname, this.totalPoints = 0, });

  @override
  List<Object> get props => [displayName, avatar, fullname];

  @override
  String toString() => 'Authenticated { displayName: $displayName, avatar: $avatar }';
}

class Unauthenticated extends AuthState {}