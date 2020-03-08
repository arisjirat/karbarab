import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/bloc/auth/auth_bloc.dart';
import 'package:karbarab/config/colors.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:karbarab/screens/home_screen.dart';
import 'package:karbarab/screens/login_screen.dart';
import 'package:karbarab/helper/sign_in.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';
  final UserRepository userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[

              // CircleAvatar(
              //   backgroundImage: NetworkImage(
              //     imageUrl,
              //   ),
              //   radius: 60,
              //   backgroundColor: Colors.transparent,
              // ),
              // SizedBox(height: 40),
              // Text(
              //   'NAME',
              //   style: TextStyle(
              //       fontSize: 15,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.black54),
              // ),
              // Text(
              //   name,
              //   style: TextStyle(
              //       fontSize: 25,
              //       color: textColor,
              //       fontWeight: FontWeight.bold),
              // ),
              // SizedBox(height: 20),
              // Text(
              //   'EMAIL',
              //   style: TextStyle(
              //       fontSize: 15,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.black54),
              // ),
              // Text(
              //   email,
              //   style: TextStyle(
              //       fontSize: 25,
              //       color: textColor,
              //       fontWeight: FontWeight.bold),
              // ),
              SizedBox(height: 40),
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
                        return LoginScreen();
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
}
