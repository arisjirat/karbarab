import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/cards/card_game.dart';
import 'package:karbarab/core/ui/cards/card_plain.dart';
import 'package:karbarab/model/quiz.dart';
import 'package:karbarab/model/score.dart';

class CardQuiz extends StatelessWidget {
  final bool isCorrect;
  final double currentPoint;
  final bool loading;
  final double deviceHeight;
  final Quiz quiz;
  final GameMode mode;
  final Widget adsHint;
  final Function giveFeedback;
  final Widget speech;

  CardQuiz({
    @required this.currentPoint,
    @required this.isCorrect,
    @required this.loading,
    @required this.deviceHeight,
    @required this.quiz,
    @required this.mode,
    @required this.adsHint,
    @required this.giveFeedback,
    @required this.speech,
  });

  @override
  Widget build(BuildContext context) {
    final double _cardPlainHeight = 0.3 * deviceHeight;
    final double _cardGameHeight = 0.4 * deviceHeight;
    return Container(
      height: _cardGameHeight,
      child: Column(
        children: [
          Stack(
            children: [
              CardPlain(
                height: _cardPlainHeight,
                color: isCorrect ? greenColor : greyColor,
                backColor: isCorrect ? greenColorLight : softGreyColor,
              ),
              CardGame(
                point: currentPoint.round(),
                correct: isCorrect,
                height: _cardGameHeight,
                loading: loading,
                quiz: quiz,
                mode: mode,
                adsHint: adsHint,
                giveFeedback: giveFeedback,
                speech: speech,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
