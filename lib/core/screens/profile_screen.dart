import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/core/bloc/auth/auth_bloc.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/repository/user_repository.dart';
import 'package:karbarab/core/screens/home_screen.dart';
import 'package:karbarab/core/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';
  final UserRepository userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is Authenticated) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      state.avatar,
                    ),
                    radius: 60,
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    state.displayName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(HomeScreen.routeName);
                        },
                        color: textColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Kembali',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      Container(
                        width: 20.0,
                      ),
                      RaisedButton(
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(
                            LoggedOut(),
                          );
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) {
                            return LoginScreen(userRepository: userRepository);
                          }), ModalRoute.withName('/'));
                        },
                        color: textColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Sign Out',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return const Text('');
    });
  }
}
