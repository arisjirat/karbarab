import 'package:flutter/material.dart';
import 'package:karbarab/config/colors.dart';
import 'package:karbarab/helper/dashed_rect.dart';
import 'package:karbarab/widgets/typography.dart';
import 'package:karbarab/config/game_mode.dart';

class CardAnswer extends StatelessWidget {
  final String answer;
  final String answerId;
  final bool currentAnswer;
  final CardAnswerMode answerMode;
  final bool disabled;
  final Function selectAnswer;

  CardAnswer({
    @required this.answer,
    @required this.answerId,
    @required this.answerMode,
    @required this.currentAnswer,
    @required this.selectAnswer,
    @required this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final arabMode = answerMode == CardAnswerMode.Arab;
    return GestureDetector(
      onTap: () {
        if (disabled) return;
        this.selectAnswer(answerId);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: currentAnswer
                ? Theme.of(context).secondaryHeaderColor
                : greyColorLight,
            boxShadow: [
              BoxShadow(
                color: textColor.withOpacity(disabled ? 0.0 : 0.2),
                blurRadius: 20.0,
                spreadRadius: 0.0,
                offset: Offset(
                  2.0,
                  10.0,
                ),
              )
            ],
          ),
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          margin: const EdgeInsets.only(top: 3.0),
          child: Row(
            mainAxisAlignment: arabMode
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10.0),
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BoldRegularText(text: answerId, dark: true),
                    Container(
                      margin: const EdgeInsets.only(left: 20.0),
                      height: 200.0,
                      child: CustomPaint(
                        painter: DashRectPainter(color: greyColor),
                      ),
                    ),
                  ],
                ),
              ),
              BoldRegularText(text: answer, dark: true),
            ],
          ),
        ),
      ),
    );
  }
}
