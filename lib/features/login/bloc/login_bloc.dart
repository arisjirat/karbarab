import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:karbarab/core/helper/log_printer.dart';
import 'package:meta/meta.dart';
import 'package:karbarab/features/login/bloc/bloc.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:password/password.dart';
import 'package:uuid/uuid.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

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
    } else if (event is LoginWithUsernamePassword) {
      yield* _mapLoginWithCredentials(event.username, event.password);
    } else if (event is SignupWithUsername) { 
      yield* _mapSignupWithUsernameToState(event.username, event.password);
    } else if (event is LoginReset) {
      yield LoginState.empty();
    }
  }

  Stream<LoginState> _mapSignupWithUsernameToState(String username, String password) async* {
    yield LoginState.loading();
    final exist = (await _userRepository.getUserFromUsername(username)).exists;
    if (exist) {
      yield LoginState.failureUserExist();
      return;
    }
    final tokenFCM = await _firebaseMessaging.getToken();
    await _userRepository.saveUser(id: Uuid().v4(), username: username, password: password, isGoogleAuth: false, tokenFCM: tokenFCM);
    yield LoginState.success();
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithGoogle();
      final username = (await _userRepository.getEmail()).split('@')[0];
      final exist = (await _userRepository.getUserFromUsername(username)).exists;
      if (!exist) {
        final tokenFCM = await _firebaseMessaging.getToken();
        await _userRepository.saveUser(id: Uuid().v4(), username: username, isGoogleAuth: true, tokenFCM: tokenFCM);
      }
      yield LoginState.success();
    } catch (err) {
      print(err);
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithCredentials(String username, String password) async* {
    yield LoginState.loading();
    final user = await _userRepository.getUserFromUsername(username);
    if (!user.exists) {
      yield LoginState.failure();
      return;
    }
    if (user['isGoogleAuth']) {
      yield LoginState.failureGoogleAuthExist();
      return;
    }
    if (Password.verify(password, user['password'])) {
      yield LoginState.success();
      return;
    }
    yield LoginState.failure();
    return;
  }
  
}