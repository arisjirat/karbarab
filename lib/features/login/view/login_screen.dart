import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:karbarab/features/auth/bloc/auth_bloc.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/features/login/bloc/bloc.dart';
import 'package:karbarab/features/login/view/login_field.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: widget.userRepository),
        child: Login(
          userRepository: widget.userRepository,
        ));
  }
}

class Login extends StatefulWidget {
  final UserRepository userRepository;
  Login({this.userRepository});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<int> _curvedAnimation;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    final Animation curve = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutQuart);
    _curvedAnimation = IntTween(
      begin: 900,
      end: 0,
    ).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward(from: 0.0);
  }

  void _inputUsername() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Align(
            alignment: Alignment.center,
            child: BoldRegularText(
              text: 'Masukan username kamu',
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            side: BorderSide(color: greenColor, width: 2),
          ),
          titlePadding: const EdgeInsets.symmetric(vertical: 20),
          content: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return BlocListener<LoginBloc, LoginState>(
                listener: (c, state) {
                  if (state.isSuccess) {
                    BlocProvider.of<AuthBloc>(context).add(LoggedIn());
                    Navigator.of(context).pushNamed(HomeScreen.routeName);
                  }
                  if (state.isUserExist) {
                    _usernameExist();
                  }
                },
                child: LoginField(
                  animation: _curvedAnimation.value,
                  loading: state is LoginState && state.isLoading,
                  next: (String username) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    BlocProvider.of<LoginBloc>(context)
                        .add(SignupUsernameWithGoogle(username));
                  },
                  dark: true,
                ),
              );
            },
          ),
        );
      },
    ).then((d) {
      BlocProvider.of<LoginBloc>(context).add(ClearGoogle());
    });
  }

  void _usernameExist() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            RaisedButton(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(color: greenColor, width: 2),
              ),
              color: whiteColor,
              child: RegularText(
                text: 'Ok',
                color: greenColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
          contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            side: BorderSide(color: greenColor, width: 2),
          ),
          titlePadding: const EdgeInsets.symmetric(vertical: 20),
          content: RegularText(
            text: 'Username sudah ada, silahkan pilih dengan yang lain',
          ),
        );
      },
    );
  }

  void _actionSingup(String username) {
    FocusScope.of(context).requestFocus(FocusNode());
    BlocProvider.of<LoginBloc>(context).add(SignupWithUsername(username));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (c, state) {
        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(LoggedIn());
          Navigator.of(context).pushNamed(HomeScreen.routeName);
        }
        if (state.needUsername) {
          _inputUsername();
        }
        if (state.isUserExist) {
          _usernameExist();
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
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return LoginField(
                            animation: _curvedAnimation.value,
                            loading: state is LoginState && state.isLoading,
                            next: _actionSingup,
                          );
                        },
                      ),
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
                          return Column(
                            children: <Widget>[
                              SmallerText(
                                text: 'Disaran kan untuk gunakan akun google',
                                dark: false,
                              ),
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
