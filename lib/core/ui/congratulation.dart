import 'package:flutter/material.dart';
import 'package:karbarab/core/config/score_value.dart';
import 'package:karbarab/core/helper/scale_calculator.dart';
import 'package:karbarab/core/ui/congrats.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/core/ui/button.dart';

class Congratulation extends StatelessWidget {
  final bool isCorrect;
  final Function onNewGame;
  final double point;
  final String nextWord;
  final double targetScore;
  const Congratulation({
    @required this.isCorrect,
    @required this.onNewGame,
    @required this.point,
    @required this.nextWord,
    this.targetScore = SCORE_BASE,
  });
  void _nextCard() {
    onNewGame();
  }

  @override
  Widget build(BuildContext context) {
    final gotWord = point >= 0 ? 'dapat' : 'minus score';
    final double padding = MediaQuery.of(context).padding.top - 25;
    final double _deviceHeight = MediaQuery.of(context).size.height - padding;
    return Container(
      height: 0.5 * _deviceHeight,
      child: Column(
        children: [
          const Image(image: AssetImage('assets/images/congratulation_character.png'), height: 200),
          Congrats(play: isCorrect, point: point, targetScore: targetScore,),
          Container(height: scaleCalculator(20.0, context)),
          BoldRegularText(
            text: 'Kamu $gotWord: ${point.toInt()} score!',
            dark: true,
          ),
          Container(height: scaleCalculator(20.0, context)),
          Button(
            onTap: _nextCard,
            text: nextWord,
          ),
        ],
      ),
    );
  }
}
