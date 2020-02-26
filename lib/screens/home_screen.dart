import 'package:flutter/material.dart';
import 'package:karbarab/config/colors.dart';
import 'package:karbarab/screens/profile_screen.dart';
import 'package:karbarab/widgets/card_play.dart';
import 'package:karbarab/config/game_mode.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SplashScreen(),
            Container(
              height: 20.0,
            ),
            CardPlay(
              color: greenColor,
              secondaryColor: greenColorLight,
              title: 'Gambar Dalam Bahasa Arab',
              score: 2,
              mode: GameMode.GambarArab
            ),
            Container(
              height: 20.0,
            ),
            CardPlay(
              color: blueColor,
              secondaryColor: blueColorLight,
              title: 'Bahasa Arab Dalam Gambar',
              score: 2,
              mode: GameMode.ArabGambar
            ),
            Container(
              height: 20.0,
            ),
            CardPlay(
              color: redColor,
              secondaryColor: redColorLight,
              title: 'Kata Dalam Bahasa Arab',
              score: 0,
              mode: GameMode.KataArab
            ),
            Container(
              height: 20.0,
            ),
            CardPlay(
              color: yellowColor,
              secondaryColor: yellowColorDark,
              title: 'Bahasa Arab dalam kata',
              score: 2,
              mode: GameMode.ArabKata
            ),
            Container(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 0.0),
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: greenColor,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: textColor,
          ),
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 5.0),
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(30.0),
                width: MediaQuery.of(context).size.width,
                child: Column(children: [
                  Image(image: AssetImage('card-logo.png')),
                  Text(
                    'Karbarab',
                    style: TextStyle(
                        fontFamily: 'FTF-Ahlan',
                        color: Colors.white,
                        fontSize: 50.0),
                  ),
                  Text(
                    'Hai, Selamat Siang',
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  Text(
                    'مرحبا مساء الخير',
                    style: TextStyle(
                        fontFamily: 'Geeza',
                        color: Colors.white,
                        fontSize: 25.0),
                  ),
                ]),
              ),
              Positioned(
                  bottom: 0.0,
                  left: 10.0,
                  child: Image(image: AssetImage('character.png'))),
              Positioned(
                top: 15.0,
                right: 15.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ProfileScreen.routeName);
                  },
                  child: Icon(
                    Icons.person_outline,
                    color: greyColorLight, size: 40.0
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
