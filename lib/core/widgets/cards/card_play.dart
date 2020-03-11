import 'package:flutter/material.dart';
import 'package:karbarab/core/screens/game_start_screen.dart';
import 'package:karbarab/core/widgets/typography.dart';
import 'package:karbarab/core/config/game_mode.dart';

class CardPlay extends StatelessWidget {
  final Color color;
  final Color secondaryColor;
  final String title;
  final int score;
  final GameMode mode;

  CardPlay({this.color, this.secondaryColor, this.title, this.score, this.mode});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameStartScreen(mode: mode),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 0.0),
              width: MediaQuery.of(context).size.width,
              height: 20.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                color: secondaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: this.color,
              ),
              width: MediaQuery.of(context).size.width,
              height: 80.0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              margin: const EdgeInsets.only(top: 3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BoldRegularText(text: title, dark: false),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                          decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.all(Radius.circular(5.0))),
                          child: SmallerText(
                            text: score > 0
                                ? 'Nilai kamu $score/10'
                                : 'Kamu belum main',
                            dark: false),
                        )
                      ],
                    ),
                  ),
                  Image(
                      image: AssetImage("assets/images/neutral_triangle_right.png"),
                      height: 35.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
