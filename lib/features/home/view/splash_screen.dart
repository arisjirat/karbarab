import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/typography.dart';

class SplashLoginScreen extends StatelessWidget {
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
                  LogoText(
                    text: 'Karbarab',
                    dark: false,
                  ),
                  Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      const Image(
                        image: AssetImage('assets/images/character.png'),
                        height: 150,
                      ),
                      const Positioned(
                        top: 100,
                        left: -45,
                        width: 200,
                        child: Image(
                          image: AssetImage('assets/images/card_logo.png'),
                          height: 110,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
