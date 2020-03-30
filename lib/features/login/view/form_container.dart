import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/core/ui/popup.dart';
import 'package:karbarab/features/login/bloc/bloc.dart';
import 'package:karbarab/features/login/view/login_form.dart';

enum CredentialsMode { LOGIN, SIGNUP }

class FormContainer extends StatefulWidget {
  FormContainer({Key key}) : super(key: key);

  @override
  _FormContainerState createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  String username;
  CredentialsMode mode = CredentialsMode.LOGIN;
  bool loading = false;

  _usernameChange() {}

  _passwordChange() {}

  void _userExist() {
    popup(
      context,
      text: 'Akun ini sudah ada, ingin login?',
      cancel: () {
        BlocProvider.of<LoginBloc>(context)
          .add(LoginReset());
        Navigator.of(context).pop();
      },
      confirm: () {
        BlocProvider.of<LoginBloc>(context)
          .add(LoginReset());
        setState(() {
          mode = CredentialsMode.LOGIN;
        });
        Navigator.of(context).pop();
      },
      cancelAble: false,
      cancelLabel: 'Perbaiki!',
      confirmLabel: 'Ya, saya ingin login',
    );
  }

  void _userError() {
    popup(
      context,
      text: 'Username dan password kamu salah?',
      cancel: () {
        BlocProvider.of<LoginBloc>(context)
          .add(LoginReset());
        Navigator.of(context).pop();
      },
      confirm: () {
        BlocProvider.of<LoginBloc>(context)
          .add(LoginReset());
        setState(() {
          mode = CredentialsMode.SIGNUP;
        });
        Navigator.of(context).pop();
      },
      cancelAble: true,
      cancelLabel: 'Perbaiki!',
      confirmLabel: 'Ya, saya buat akun baru',
    );
  }

  void _userExistInGoogleAuth() {
    popup(
      context,
      text: 'Akun ini sudah terdaftar melalui google auth?',
      cancel: () {
        BlocProvider.of<LoginBloc>(context)
          .add(LoginReset());
        Navigator.of(context).pop();
      },
      confirm: () {
        BlocProvider.of<LoginBloc>(context)
          .add(LoginReset());
        BlocProvider.of<LoginBloc>(context)
          .add(LoginWithGooglePressed());
        Navigator.of(context).pop();
      },
      cancelAble: true,
      cancelLabel: 'Perbaiki!',
      confirmLabel: 'Ya, login melalui Akun Google',
    );
  }

  void _loginHandler(String username, String password) async {
    if (mode == CredentialsMode.LOGIN) {
      BlocProvider.of<LoginBloc>(context)
        .add(LoginWithUsernamePassword(username, password));
    } else if (mode == CredentialsMode.SIGNUP) {
      BlocProvider.of<LoginBloc>(context)
        .add(SignupWithUsername(username, password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginState && state.isUserExist) {
          _userExist();
        }
        if (state is LoginState && state.isFailure) {
          _userError();
        }
        if (state is LoginState && state.errorIsGoogleAccountExist) {
          _userExistInGoogleAuth();
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return LoginForm(
            mode: mode,
            loginHandler: _loginHandler,
            loading: state is LoginState && state.isLoading,
          );
        },
      ),
    );
  }
}
