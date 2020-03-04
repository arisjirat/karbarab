import 'package:flutter/material.dart';
import 'package:karbarab/helper/sign_in.dart';
import 'package:karbarab/config/colors.dart';
import 'package:karbarab/screens/home_screen.dart';

import 'package:karbarab/widgets/typography.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Image(image: AssetImage('lib/assets/images/character.png')),
                    _signInButton(),
                  ],
                )
              ],
            )
          ],
        ));
  }

  Widget _signInButton() {
    return RaisedButton(
      color: Colors.white,
      onPressed: () {
        signInWithGoogle()
          .catchError((err) {
            print(err);
          })
          .then((value) {
            // todo loading
            if (value != null) {
              Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                },
              ),
            );
            }
          });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("lib/assets/images/google_logo.png"), height: 35.0),
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