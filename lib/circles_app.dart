import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/features/admob/bloc/admob_bloc.dart';
import 'package:karbarab/features/auth/bloc/auth_bloc.dart';
import 'package:karbarab/features/auth/view/profile_screen.dart';
import 'package:karbarab/features/battle/bloc/battle_bloc.dart';
import 'package:karbarab/features/battle/view/battle_screen.dart';
import 'package:karbarab/features/battle_list/bloc/battle_list_bloc.dart';
import 'package:karbarab/features/feedback/bloc/feedback_bloc.dart';
import 'package:karbarab/features/global_scores/bloc/global_scores_bloc.dart';
import 'package:karbarab/features/home/view/home_screen.dart';
import 'package:karbarab/features/home/view/splash_screen.dart';
import 'package:karbarab/features/karbarab/view/karbarab.dart';
import 'package:karbarab/features/login/bloc/login_bloc.dart';
import 'package:karbarab/features/login/view/login_screen.dart';
import 'package:karbarab/features/notification/bloc/notification_bloc.dart';
import 'package:karbarab/features/notification/view/app_pushes.dart';
import 'package:karbarab/features/quiz/bloc/quiz_bloc.dart';
import 'package:karbarab/features/quiz/view/game_start_screen.dart';
import 'package:karbarab/features/score/bloc/score_bloc.dart';
import 'package:karbarab/features/send_card_limit/bloc/send_card_limit_bloc.dart';
import 'package:karbarab/features/users/bloc/users_bloc.dart';
import 'package:karbarab/features/voices/bloc/voices_bloc.dart';
import 'package:karbarab/model/score.dart';
import 'package:karbarab/repository/quiz_repository.dart';
import 'package:karbarab/repository/user_repository.dart';

class CirclesApp extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  final QuizRepository quizRepository = QuizRepository();

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
          create: (BuildContext context) => LoginBloc(
            userRepository: userRepository,
          ),
        ),
        BlocProvider(
          create: (BuildContext context) => VoicesBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => BattleListBloc(userRepository: userRepository,),
        ),
        BlocProvider(
          create: (BuildContext context) => SendCardLimitBloc(),
        ),
      ],
      child: App(userRepository: userRepository),
    );
  }
}

class App extends StatefulWidget {
  final UserRepository userRepository;
  const App({@required this.userRepository});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return AppPushs(
      navigatorKey: _navigatorKey,
      child: MaterialApp(
        title: 'Karbarab',
        navigatorKey: _navigatorKey,
        theme: ThemeData(
          primaryColor: primaryColor,
          secondaryHeaderColor: secondaryColor,
          fontFamily: 'Proxima',
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (BuildContext context, AuthState state) {
            if (state is Unauthenticated) {
              return LoginScreen(userRepository: widget.userRepository);
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
          LoginScreen.routeName: (_) => LoginScreen(userRepository: widget.userRepository),
          HomeScreen.routeName: (_) => HomeScreen(),
          ProfileScreen.routeName: (_) => ProfileScreen(),
          BattleScreen.routeName: (_) => const BattleScreen(),
          GameStartScreen.routeName: (_) => GameStartScreen(mode: GameMode.GambarArab),
          KarbarabScreen.routeName: (_) => KarbarabScreen(),
        },
      ),
    );
  }
}
