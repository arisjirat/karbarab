import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:karbarab/repository/score_repostitory.dart';
import 'package:meta/meta.dart';
import 'package:karbarab/repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final UserRepository _userRepository;
  final ScoreRepository _scoreRepository = ScoreRepository();

  AuthBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final name = await _userRepository.getUser();
        final avatar = await _userRepository.getAvatar();
        final fullname = await _userRepository.getUserFullname();
        final isGoogleAuth = await _userRepository.isUserGoogleAuth();
        final userId = await _userRepository.getUserId();
        final scores = await _scoreRepository.getUserScore(userId);
        final tokenFCM = await _userRepository.getUserTokenFCM();
        final totalScore = await scores.fold(0, (t, e) => e['score'] + t);

        yield Authenticated(
          displayName: name,
          avatar: avatar,
          fullname: fullname,
          totalPoints: totalScore,
          isGoogleAuth: isGoogleAuth,
          tokenFCM: tokenFCM
        );
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapLoggedInToState() async* {
    final name = await _userRepository.getUser();
    final avatar = await _userRepository.getAvatar();
    final fullname = await _userRepository.getUserFullname();
    final userId = await _userRepository.getUserId();
    final isGoogleAuth = await _userRepository.isUserGoogleAuth();
    final scores = await _scoreRepository.getUserScore(userId);
    final totalScore = await scores.fold(0, (t, e) => e['score'] + t);
    final tokenFCM = await _userRepository.getUserTokenFCM();

    final newToken = await _firebaseMessaging.getToken();

    if (newToken != tokenFCM) {
      _userRepository.updateUserTokenFCM(name, newToken);
    }

    yield Authenticated(
        displayName: name,
        avatar: avatar,
        isGoogleAuth: isGoogleAuth,
        fullname: fullname,
        tokenFCM: newToken != tokenFCM ? newToken : tokenFCM,
        totalPoints: totalScore);
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}
