import 'package:flutter/material.dart';
import 'package:karbarab/core/helper/scale_calculator.dart';
import 'package:karbarab/core/widgets/congrats.dart';
import 'package:karbarab/core/widgets/typography.dart';
import 'package:karbarab/core/widgets/button.dart';

class Congratulation extends StatelessWidget {
  final bool isCorrect;
  final Function onNewGame;
  final int point;
  const Congratulation({
    @required this.isCorrect,
    @required this.onNewGame,
    @required this.point,
  });
  void _nextCard() {
    onNewGame();
  }

  @override
  Widget build(BuildContext context) {
    final double padding = MediaQuery.of(context).padding.top - 25;
    final double _deviceHeight = MediaQuery.of(context).size.height - padding;
    return Container(
      height: 0.5 * _deviceHeight,
      child: Column(
        children: [
          const Image(image: AssetImage('assets/images/congratulation_character.png'), height: 200),
          Congrats(play: isCorrect),
          Container(height: scaleCalculator(20.0, context)),
          BoldRegularText(
            text: 'Kamu dapat ${point.toString()} points!',
            dark: true,
          ),
          Container(height: scaleCalculator(20.0, context)),
          Button(
            onTap: _nextCard,
            text: 'Kata Selanjutnya',
          ),
        ],
      ),
    );
  }
}
