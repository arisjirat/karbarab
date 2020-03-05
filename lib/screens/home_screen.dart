import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:karbarab/config/colors.dart';
import 'package:karbarab/helper/greetings.dart';
import 'package:karbarab/screens/profile_screen.dart';
import 'package:karbarab/widgets/cards/card_play.dart';
import 'package:karbarab/config/game_mode.dart';
import 'package:karbarab/widgets/typography.dart';
import 'package:karbarab/helper/scale_calculator.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  @override
  Widget build(BuildContext context) {
    final double padding = MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom;
    final double _deviceHeight = MediaQuery.of(context).size.height - padding;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SplashScreen(deviceHeight: _deviceHeight),
            Container(
              height: 0.7 * _deviceHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardPlay(
                    color: greenColor,
                    secondaryColor: greenColorLight,
                    title: 'Gambar Dalam Bahasa Arab',
                    score: 2,
                    mode: GameMode.GambarArab,
                  ),
                  Container(height: scaleCalculator(20.0, context)),
                  CardPlay(
                    color: blueColor,
                    secondaryColor: blueColorLight,
                    title: 'Bahasa Arab Dalam Gambar',
                    score: 2,
                    mode: GameMode.ArabGambar,
                  ),
                  Container(height: scaleCalculator(20.0, context)),
                  CardPlay(
                    color: redColor,
                    secondaryColor: redColorLight,
                    title: 'Kata Dalam Bahasa Arab',
                    score: 0,
                    mode: GameMode.KataArab,
                  ),
                  Container(height: scaleCalculator(20.0, context)),
                  CardPlay(
                    color: yellowColor,
                    secondaryColor: yellowColorDark,
                    title: 'Bahasa Arab dalam kata',
                    score: 2,
                    mode: GameMode.ArabKata,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  final double deviceHeight;

  SplashScreen({this.deviceHeight});

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 0.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: greenColor,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 5.0),
          height: (0.3 * deviceHeight) - 5.0,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('lib/assets/images/card_logo.png'),
                      height: deviceHeight / 10,
                    ),
                    LogoText(text: 'Karbarab', dark: true),
                    RegularText(text: 'Hai, Selamat ${greeting()}', dark: true),
                    ArabicText(text: 'مرحبا مساء الخير', dark: true),
                  ],
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 10.0,
                child: Image(
                  image: AssetImage('lib/assets/images/character.png'),
                  height: deviceHeight / 8,
                ),
              ),
              Positioned(
                top: 15.0,
                right: 15.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ProfileScreen.routeName);
                  },
                  child: Icon(
                    Icons.person_outline,
                    color: greyColorLight,
                    size: 40.0,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
