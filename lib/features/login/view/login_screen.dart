import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:karbarab/features/auth/bloc/auth_bloc.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/features/login/bloc/bloc.dart';
import 'package:karbarab/features/login/view/form_container.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:karbarab/features/home/view/home_screen.dart';
import 'package:karbarab/core/ui/typography.dart';

enum CredentialsMode { LOGIN, SIGNUP }

class LoginScreen extends StatefulWidget {
  final UserRepository userRepository;
  static const String routeName = '/login';

  LoginScreen({@required this.userRepository});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  CredentialsMode mode = CredentialsMode.LOGIN;
  String asdsa;

  void _changeCredentialMode(CredentialsMode credmode) {
    setState(() {
      mode = credmode;
    });
  }

  @override
  void initState() {
    setState(() {
      mode = CredentialsMode.LOGIN;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(userRepository: widget.userRepository),
      child: Login(
          userRepository: widget.userRepository,
          mode: mode,
          onModeChange: _changeCredentialMode),
    );
  }
}

class Login extends StatelessWidget {
  final UserRepository userRepository;
  final CredentialsMode mode;
  final Function(CredentialsMode) onModeChange;
  Login(
      {this.userRepository, @required this.mode, @required this.onModeChange});
  @override
  Widget build(BuildContext context) {
    print(mode);
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
                      LogoText(
                        text: 'Karbarab',
                        dark: false,
                      ),
                      const Image(
                        image: AssetImage('assets/images/character.png'),
                        height: 120,
                      ),
                      FormContainer(mode: mode, onModeChange: onModeChange),
                      const SizedBox(height: 60),
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
                          return Row(
                            children: <Widget>[
                              MaterialButton(
                                padding: const EdgeInsets.all(10),
                                minWidth: 100,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  side: BorderSide(color: whiteColor, width: 2),
                                ),
                                color: whiteColor,
                                child: SmallerText(
                                  dark: true,
                                  text: mode == CredentialsMode.LOGIN
                                      ? 'Buat Akun'
                                      : 'Login',
                                ),
                                onPressed: () {
                                  if (mode == CredentialsMode.LOGIN) {
                                    onModeChange(CredentialsMode.SIGNUP);
                                  } else {
                                    onModeChange(CredentialsMode.LOGIN);
                                  }
                                },
                              ),
                              const SizedBox(width: 10),
                              GoogleSignInButton(),
                            ],
                          );
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
    final LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);
    return RaisedButton(
      color: whiteColor,
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
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SmallerText(
                text: 'Masuk Akun Google',
                dark: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
