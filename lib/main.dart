import 'package:flutter/material.dart';
import 'package:karbarab/screens/game_start_screen.dart';
import 'package:karbarab/screens/login_screen.dart';
import 'package:karbarab/screens/home_screen.dart';
import 'package:karbarab/config/colors.dart';
import 'package:karbarab/screens/profile_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karbarab',
      theme: ThemeData(
        // primarySwatch: primaryColor,
        primaryColor: primaryColor,
        secondaryHeaderColor: secondaryColor,
        // secondaryColor: secondaryColor,
        fontFamily: 'Proxima',
      ),
      home: GameStartScreen(),
      // initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        ProfileScreen.routeName: (_) => ProfileScreen(),
        GameStartScreen.routeName: (_) => GameStartScreen()
      }
    );
  }
}
