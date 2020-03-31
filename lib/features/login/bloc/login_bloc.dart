import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:karbarab/features/auth/model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:karbarab/features/login/bloc/bloc.dart';
import 'package:karbarab/repository/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is SignupWithUsername) {
      yield* _mapSignupUsernameToState(event.username);
    } else if (event is SignupUsernameWithGoogle) {
      yield* _mapSignupUsernameGoogleToState(event.username);
    } else if (event is LoginReset) {
      yield LoginState.empty();
    } else if (event is ClearGoogle) {
      yield LoginState.loading();
      await _userRepository.signOutGoogleOnly();
      yield LoginState.empty();
    }
  }

  Stream<LoginState> _mapSignupUsernameToState(
    String username,
  ) async* {
    yield LoginState.loading();
    final exist = (await _userRepository.getUserFromUsername(username)).exists;
    if (exist) {
      yield LoginState.failureUserExist();
      return;
    }
    await _userRepository.saveUser(
      username: username,
      isGoogleAuth: false,
    );
    yield LoginState.success();
  }

  Stream<LoginState> _mapSignupUsernameGoogleToState(
    String username,
  ) async* {
    yield LoginState.loading();
    final exist = (await _userRepository.getUserFromUsername(username)).exists;
    if (exist) {
      yield LoginState.failureUserExist();
      return;
    }
    await _userRepository.saveUser(
      username: username,
      isGoogleAuth: true,
    );
    yield LoginState.success();
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithGoogle();
      final email = await _userRepository.getEmailFirebase();
      final user = await _userRepository.getUserFromEmail(email);

      if (user.isNotEmpty) {
        final singleUser = user.toList()[0];
        final UserModel userData = UserModel(
          id: singleUser['id'],
          email: singleUser['email'],
          username: singleUser['username'],
          isGoogleAuth: singleUser['isGoogleAuth'],
          tokenFCM: singleUser['tokenFCM'],
          fullname: singleUser['fullname'],
          avatar: singleUser['avatar'],
        );
        await _userRepository.saveUserToLocal(userData);
        yield LoginState.success();
        return;
      }
      yield LoginState.successNeedUsername();
    } catch (err) {
      yield LoginState.failure();
    }
  }
}
