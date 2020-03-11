import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/core/screens/game_start_screen.dart';
import 'package:karbarab/core/screens/login_screen.dart';
import 'package:karbarab/core/screens/home_screen.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/screens/profile_screen.dart';
import 'package:karbarab/core/helper/bloc_delegate.dart';
import 'package:karbarab/core/bloc/auth/auth_bloc.dart';
import 'package:karbarab/core/repository/user_repository.dart';
import 'package:karbarab/core/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runApp(
    BlocProvider(
      create: (context) => AuthBloc(
        userRepository: userRepository,
      )..add(AppStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karbarab',
      theme: ThemeData(
        primaryColor: primaryColor,
        secondaryHeaderColor: secondaryColor,
        fontFamily: 'Proxima',
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          print(state);
          if (state is Unauthenticated) {
            return LoginScreen(userRepository: userRepository);
          }
          if (state is Authenticated) {
            // return ProfileScreen();
            return HomeScreen(displayName: state.displayName);
          }
          if (state is Uninitialized) {
            return SplashLoginScreen();
          }
          return SplashLoginScreen();
        },
      ),
      routes: {
        LoginScreen.routeName: (_) =>
            LoginScreen(userRepository: userRepository),
        HomeScreen.routeName: (_) => HomeScreen(),
        ProfileScreen.routeName: (_) => ProfileScreen(),
        GameStartScreen.routeName: (_) =>
            GameStartScreen(mode: GameMode.GambarArab)
      },
    );
  }
}
