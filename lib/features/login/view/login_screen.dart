import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:karbarab/features/auth/bloc/auth_bloc.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/features/login/bloc/bloc.dart';
// import 'package:karbarab/core/helper/greetings.dart';
import 'package:karbarab/features/login/view/form_container.dart';
import 'package:karbarab/features/login/view/signup_form.dart';
// import 'package:karbarab/features/login/view/signup_form.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:karbarab/features/home/view/home_screen.dart';
import 'package:karbarab/core/ui/typography.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;
  static const String routeName = '/login';

  LoginScreen({@required this.userRepository});

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
  Login({this.userRepository});
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
        body: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 60),
                      const Image(
                        image: AssetImage('assets/images/card_logo.png'),
                      ),
                      // ArabicText(
                      //   text: 'مرحبا مساء الخير',
                      //   dark: false,
                      // ),
                      // BiggerText(
                      //   text: 'Hai, Selamat ${greeting()}',
                      //   dark: false,
                      // ),
                      LogoText(
                        text: 'Karbarab',
                        dark: false,
                      ),
                      const Image(
                        image: AssetImage('assets/images/character.png'),
                        height: 120,
                      ),
                      FormContainer(),
                      // SignupForm(loginHandler: () {},),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state is LoginState) {
                            if (state.isLoading) {
                              return const Padding(
                                padding: EdgeInsets.all(20),
                                child: SpinKitDoubleBounce(color: whiteColor),
                              );
                            }
                          }
                          return GoogleSignInButton();
                        },
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
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
      shape: const RoundedRectangleBorder(
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
            const Image(
              image: AssetImage('assets/images/google_logo.png'),
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
