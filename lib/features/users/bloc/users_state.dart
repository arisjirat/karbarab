part of 'users_bloc.dart';

@immutable
class UsersState {
  final bool isSuccess;
  final bool isFailure;
  final bool isLoading;
  final List<UserModel> users;

  UsersState({
    @required this.isSuccess,
    @required this.isFailure,
    @required this.isLoading,
    this.users,
  });

  factory UsersState.empty() {
    return UsersState(
      isSuccess: false,
      isFailure: false,
      isLoading: false,
      users: [],
    );
  }

  factory UsersState.loading() {
    return UsersState(
      isSuccess: false,
      isFailure: false,
      isLoading: true,
      users: [],
    );
  }

  factory UsersState.failure() {
    return UsersState(
      isSuccess: false,
      isFailure: true,
      isLoading: false,
      users: [],
    );
  }

  factory UsersState.success(users) {
    return UsersState(
      isSuccess: true,
      isFailure: false,
      isLoading: false,
      users: users,
    );
  }

  UsersState copyWith({
    bool isSuccess,
    bool isFailure,
    bool isLoading,
    bool isUserExist,
    List<UserModel> isUsers,
  }) {
    return UsersState(
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isLoading: isLoading ?? this.isLoading,
      users: isUsers.isEmpty ?? users,
    );
  }

  @override
  String toString() {
    return '''UsersState {
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isLoading: $isLoading,
      users: $users,
    }''';
  }
}
