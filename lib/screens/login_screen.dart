import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/bloc/auth/auth_bloc.dart';
import 'package:karbarab/config/colors.dart';
import 'package:karbarab/bloc/login/bloc.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:karbarab/screens/home_screen.dart';
import 'package:karbarab/widgets/typography.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        userRepository = userRepository,
        super(key: key);

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(userRepository: userRepository),
      child: Login(userRepository: userRepository),
    );
  }
}

class Login extends StatelessWidget {
  final UserRepository userRepository;
  Login({ this.userRepository });
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(LoggedIn());
          Navigator.of(context).pushNamed(HomeScreen.routeName);
        }
      },
      child: Scaffold(
        backgroundColor: greenColor,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image(image: AssetImage('lib/assets/images/card_logo.png')),
                    ArabicText(
                      text: 'مرحبا مساء الخير',
                      dark: false,
                    ),
                    BiggerText(
                      text: 'Hai, Selamat Siang',
                      dark: false,
                    ),
                    LogoText(
                      text: 'Karbarab',
                      dark: false,
                    ),
                    Image(
                      image: AssetImage('lib/assets/images/character.png'),
                      height: 120,
                    ),
                    GoogleSignInButton(),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);

    return RaisedButton(
      color: Colors.white,
      onPressed: () {
        _loginBloc.add(LoginWithGooglePressed());
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("lib/assets/images/google_logo.png"),
              height: 35.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
