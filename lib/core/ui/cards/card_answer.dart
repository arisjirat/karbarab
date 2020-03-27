import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/helper/dashed_rect.dart';
import 'package:karbarab/features/quiz/model/quiz.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/core/config/game_mode.dart';

class CardAnswer extends StatelessWidget {
  final QuizModel item;
  final String answerId;
  final bool currentAnswer;
  final GameMode answerMode;
  final bool disabled;
  final bool loading;
  final bool hint;
  final Function selectAnswer;

  CardAnswer({
    Key key,
    @required this.item,
    @required this.answerId,
    @required this.answerMode,
    @required this.currentAnswer,
    @required this.selectAnswer,
    @required this.hint,
    @required this.loading,
    this.disabled = false,
  }) : super(key: key);

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
    return const Text('warn front');
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
    return MediaQuery.of(context).size.width - 50;
  }

  double getHeightMode(BuildContext context, GameMode mode) {
    if (mode == GameMode.ArabGambar) {
      return 120;
    }
    return 50;
  }

  Widget buildCross({String type = 'left'}) {
    return disabled
        ? Positioned(
            child: Container(
              height: 20,
              width: 2,
              child: Transform.rotate(
                angle: type == 'left' ? 45 : 65,
                child: Container(
                  color: redColor,
                  height: 1.0,
                  width: 1,
                ),
              ),
            ),
            top: 1,
            left: 5,
          )
        : const Padding(padding: EdgeInsets.all(0),);
  }

  Widget buildMode(BuildContext context) {
    if (isGambarMode(answerMode)) {
      return Stack(
        children: [
          Positioned(
            top: 10,
            left: 0,
            child: Stack(
              children: <Widget>[
                RegularText(text: answerId, dark: true),
                buildCross(type: 'left'),
                buildCross(type: 'right'),
              ],
            ),
          ),
          Container(
            height: getHeightMode(context, answerMode),
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
    return Stack(
      children: <Widget>[
        Row(
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
                  Stack(
                    children: <Widget>[
                      BoldRegularText(text: answerId, dark: true),
                      buildCross(type: 'left'),
                      buildCross(type: 'right'),
                    ],
                  ),
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (disabled) {
          return;
        }
        selectAnswer(answerId);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: hint ? 2.0 : 0, color: hint ? greenColor : greenColor.withOpacity(0)),
              color: currentAnswer
                  ? Theme.of(context).secondaryHeaderColor
                  : disabled ? greyColor.withOpacity(0.6) : greyColorLight,
              boxShadow: [
                BoxShadow(
                  color: textColor.withOpacity(disabled ? 0.0 : 0.2),
                  blurRadius: 20.0,
                  spreadRadius: 0.0,
                  offset: const Offset(
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
