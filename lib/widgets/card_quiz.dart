import 'package:flutter/material.dart';
import 'package:karbarab/config/colors.dart';
import 'package:karbarab/config/game_mode.dart';
import 'package:karbarab/helper/model_quiz.dart';
import 'package:karbarab/widgets/card_game.dart';
import 'package:karbarab/widgets/card_plain.dart';

class CardQuiz extends StatelessWidget {
  final bool isCorrect;
  final double currentPoint;
  final bool loading;
  final double deviceHeight;
  final QuizModel quiz;
  final GameMode mode;

  CardQuiz({
    @required this.currentPoint,
    @required this.isCorrect,
    @required this.loading,
    @required this.deviceHeight,
    @required this.quiz,
    @required this.mode,
  });

  Widget build(BuildContext context) {
    final double _cardPlainHeight = 0.3 * deviceHeight;
    final double _cardGameHeight = 0.3 * deviceHeight;
    return Container(
      height: 0.4 * deviceHeight,
      child: Column(
        children: [
          Stack(
            children: [
              CardPlain(
                height: _cardPlainHeight,
                color: isCorrect ? greenColor : greyColor,
                secondaryColor: isCorrect ? greenColorLight : softGreyColor,
              ),
              CardGame(
                point: currentPoint.round(),
                correct: isCorrect,
                height: _cardGameHeight,
                loading: loading,
                quiz: quiz,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
