import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/features/admob/bloc/admob_bloc.dart';
import 'package:karbarab/features/auth/bloc/auth_bloc.dart';
import 'package:karbarab/features/auth/view/profile_screen.dart';
import 'package:karbarab/features/battle/bloc/battle_bloc.dart';
import 'package:karbarab/features/battle/view/battle.dart';
import 'package:karbarab/features/feedback/bloc/feedback_bloc.dart';
import 'package:karbarab/features/global_scores/bloc/global_scores_bloc.dart';
import 'package:karbarab/features/home/view/home_screen.dart';
import 'package:karbarab/features/home/view/splash_screen.dart';
import 'package:karbarab/features/karbarab/view/karbarab.dart';
import 'package:karbarab/features/login/bloc/login_bloc.dart';
import 'package:karbarab/features/login/view/login_screen.dart';
import 'package:karbarab/features/notification/bloc/notification_bloc.dart';
import 'package:karbarab/features/quiz/bloc/quiz_bloc.dart';
import 'package:karbarab/features/quiz/view/game_start_screen.dart';
import 'package:karbarab/features/score/bloc/score_bloc.dart';
import 'package:karbarab/features/users/bloc/users_bloc.dart';
import 'package:karbarab/features/voices/bloc/voices_bloc.dart';
import 'package:karbarab/repository/quiz_repository.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:karbarab/utils/logger.dart';

class CirclesApp extends StatefulWidget {

  @override
  _CirclesAppState createState() => _CirclesAppState();
}

Future<dynamic> _myBackgroundMessageHandler(Map<String, dynamic> message) async {
    // if (message.containsKey('data')) {
    //   // Handle data message
    //   final dynamic data = message['data'];
    //   Logger.w('[Background comming] $data');
    // }

    // if (message.containsKey('notification')) {
    //   // Handle notification message
    //   final dynamic notification = message['notification'];
    //   Logger.w('[Background comming notification] $notification');
    // }
    Logger.w('[Background comming notification] $message');
    // print(message);
    return message;
    // Or do other work.
  }

class _CirclesAppState extends State<CirclesApp> {

  


  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final UserRepository userRepository = UserRepository();
  final QuizRepository quizRepository = QuizRepository();

  @override
  void initState() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        Logger.w('onMessage');
        try {
          final data = message['data'];
          final String quizId = data['quizId'];
          final String userId = data['userSenderId'];
          // final String userId = data['userSenderId'];
          // getLogger('FCM').e('name: $name & age: $age');
          Logger.w('Message comming $quizId, $userId');
        } catch (error) {
          Logger.e('onMessage', e: error, s: StackTrace.current);
        }
        return true;
      },
      onLaunch: (Map<String, dynamic> message) async {
        Logger.w('onLaunch');
        try {
          final data = message['data'];
          final String quizId = data['quizId'];
          final String userId = data['userSenderId'];
          // final String userId = data['userSenderId'];
          // getLogger('FCM').e('name: $name & age: $age');
          Logger.w('onLaunch Message comming $quizId, $userId');
        } catch (error) {
          Logger.e('onLaunch', e: error, s: StackTrace.current);
        }
        return true;
      },
      onResume: (Map<String, dynamic> message) async {
        Logger.w('Resume');
        try {
          final data = message['data'];
          final String quizId = data['quizId'];
          final String userId = data['userSenderId'];
          // final String userId = data['userSenderId'];
          // getLogger('FCM').e('name: $name & age: $age');
          Logger.w('Resume Message comming $quizId, $userId');
        } catch (error) {
          Logger.e('Resume', e: error, s: StackTrace.current);
        }
        return true;
      },
      // onBackgroundMessage: Platform.isIOS ? null : _myBackgroundMessageHandler,

    );
    // _firebaseMessaging.getToken().then((String token) {
    //   Logger.w('Token new: $token');
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
          create: (BuildContext context) => UsersBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => AdmobBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => FeedbackBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => NotificationBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => BattleBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => LoginBloc(userRepository: userRepository,),
        ),
        BlocProvider(
          create: (BuildContext context) => VoicesBloc(),
        ),
      ],
      child: App(userRepository: userRepository),
    );
  }
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
            // return BattleScreen();
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
        BattleScreen.routeName: (_) => BattleScreen(),
        GameStartScreen.routeName: (_) => GameStartScreen(mode: GameMode.GambarArab),
        KarbarabScreen.routeName: (_) => KarbarabScreen(),
      },
    );
  }
}
