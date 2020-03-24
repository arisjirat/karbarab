import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/features/admob/bloc/admob_bloc.dart';
import 'package:karbarab/features/feedback/bloc/feedback_bloc.dart';
import 'package:karbarab/features/global_scores/bloc/global_scores_bloc.dart';
import 'package:karbarab/features/karbarab/view/karbarab.dart';
import 'package:karbarab/features/quiz/bloc/quiz_bloc.dart';
import 'package:karbarab/features/quiz/view/game_start_screen.dart';
import 'package:karbarab/features/login/view/login_screen.dart';
import 'package:karbarab/features/home/view/home_screen.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/features/auth/view/profile_screen.dart';
import 'package:karbarab/core/helper/bloc_delegate.dart';
import 'package:karbarab/features/auth/bloc/auth_bloc.dart';
import 'package:karbarab/features/score/bloc/score_bloc.dart';
import 'package:karbarab/repository/quiz_repository.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:karbarab/features/home/view/splash_screen.dart';
import 'package:logger/logger.dart';

void main() {
  Logger.level = Level.verbose;
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  final QuizRepository quizRepository = QuizRepository();
  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AuthBloc(
            userRepository: userRepository,
          )..add(AppStarted()),
        ),
        BlocProvider(
          create: (BuildContext context) => QuizBloc(
            quizRepository: quizRepository,
          )..add(Initialize()),
        ),
        BlocProvider(
          create: (BuildContext context) => ScoreBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => GlobalScoresBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => AdmobBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => FeedbackBloc(),
        ),
      ],
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  const App({@required this.userRepository});

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
        builder: (BuildContext context, AuthState state) {
          if (state is Unauthenticated) {
            return LoginScreen(userRepository: userRepository);
          }
          if (state is Authenticated) {
            return HomeScreen();
          }
          if (state is Uninitialized) {
            return SplashLoginScreen();
          }
          return SplashLoginScreen();
        },
      ),
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(userRepository: userRepository),
        HomeScreen.routeName: (_) => HomeScreen(),
        ProfileScreen.routeName: (_) => ProfileScreen(),
        GameStartScreen.routeName: (_) => GameStartScreen(mode: GameMode.GambarArab),
        KarbarabScreen.routeName: (_) => KarbarabScreen(),
      },
    );
  }
}
