import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karbarab/features/auth/model/user_model.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepository _userRepository = UserRepository();
  @override
  UsersState get initialState => UsersState.empty();

  @override
  Stream<UsersState> mapEventToState(
    UsersEvent event,
  ) async* {
    if (event is GetUsers) {
      yield UsersState.loading();
      try {
        final List<DocumentSnapshot> usersData =
            await _userRepository.getAllUsers();
        final List<UserModel> users = usersData.map(
          (u) => UserModel(
            id: u['id'],
            username: u['username'],
            isGoogleAuth: u['isGoogleAuth'],
            tokenFCM: u['tokenFCM'],
            avatar: u['avatar'],
            email: u['email'],
            fullname: u['fullname'],
          ),
        ).toList();
        yield UsersState.success(users);
        return;
      } catch (e) {
        yield UsersState.failure();
      }
    }
  }
}
