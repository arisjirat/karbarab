import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:karbarab/model/user.dart';
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
        final List<User> users = usersData.map(
          (u) => UserRepository.fromDoc(u),
        ).toList();
        final username = await _userRepository.getUser();
        users.removeWhere((u) => u.username == username);
        yield UsersState.success(users);
        return;
      } catch (e) {
        yield UsersState.failure();
      }
    }
  }
}
