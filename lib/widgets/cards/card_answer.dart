import 'package:flutter/material.dart';
import 'package:karbarab/config/colors.dart';
import 'package:karbarab/helper/dashed_rect.dart';
import 'package:karbarab/helper/model_quiz.dart';
import 'package:karbarab/widgets/typography.dart';
import 'package:karbarab/config/game_mode.dart';

class CardAnswer extends StatelessWidget {
  final QuizModel item;
  final String answerId;
  final bool currentAnswer;
  final GameMode answerMode;
  final bool disabled;
  final bool loading;
  final Function selectAnswer;

  CardAnswer({
    @required this.item,
    @required this.answerId,
    @required this.answerMode,
    @required this.currentAnswer,
    @required this.selectAnswer,
    @required this.loading,
    this.disabled = false,
  });

  Widget _buildAnswer(context) {
    switch (answerMode) {
      case GameMode.GambarArab:
        return BoldRegularText(text: item.arab, dark: true);
      case GameMode.ArabGambar:
        return Image.network(
          item.image,
          width: 70,
          fit: BoxFit.fitWidth,
        );
      case GameMode.ArabKata:
        return BoldRegularText(text: item.bahasa, dark: true);
      case GameMode.KataArab:
        return BoldRegularText(text: item.arab, dark: true);
    }
    return Text('warn front');
  }

  bool isArabMode(GameMode answerModeParams) {
    return answerMode == GameMode.GambarArab || answerMode == GameMode.KataArab;
  }

  bool isGambarMode(GameMode answerModeParams) {
    return answerMode == GameMode.ArabGambar;
  }

  double getWidthMode(BuildContext context, GameMode mode) {
    if (mode == GameMode.ArabGambar) {
      return (MediaQuery.of(context).size.width / 2) - 50;
    }
    return MediaQuery.of(context).size.width;
  }

  double getHeightMode(BuildContext context, GameMode mode) {
    if (mode == GameMode.ArabGambar) {
      return 120;
    }
    return 50;
  }

  Widget buildMode(BuildContext context) {
    if (isGambarMode(answerMode)) {
      return Stack(
        children: [
          Positioned(
            top: 10,
            left: 0,
            child: RegularText(text: answerId, dark: true),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                loading
                    ? BoldRegularText(text: '...', dark: true)
                    : _buildAnswer(context)
              ],
            ),
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: isArabMode(answerMode)
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
        loading
            ? BoldRegularText(text: '...', dark: true)
            : _buildAnswer(context)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (disabled) return;
        this.selectAnswer(answerId);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
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
            width: getWidthMode(context, answerMode),
            height: getHeightMode(context, answerMode),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            margin: const EdgeInsets.only(top: 3.0),
            child: buildMode(context)),
      ),
    );
  }
}
