import 'package:flutter/material.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/cards/point.dart';

class CardText extends StatelessWidget {
  final int point;
  final String text;
  final String voice;
  final double height;
  final bool loading;
  final bool isCorrect;
  final Widget adsHint;
  final CardAnswerMode answerMode;
  final Function giveFeedback;
  final Widget speech;

  CardText({
    Key key,
    @required this.point,
    @required this.text,
    @required this.height,
    @required this.loading,
    @required this.answerMode,
    @required this.isCorrect,
    @required this.adsHint,
    @required this.giveFeedback,
    @required this.speech,
    this.voice = '',
  }) : super(key: key);

  Widget _buildText() {
    if (answerMode == CardAnswerMode.Arab) {
      return BiggerArabicText(
        text: text,
        dark: true,
      );
    }
    return LargerText(
      text: text,
      dark: true,
      bold: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height - 80,
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loading
                  ? RegularText(text: 'Loading', dark: true)
                  : _buildText()
            ],
          ),
        ),
        PointCard(point),
        Positioned(
          top: 10.0,
          right: 10.0,
          child: answerMode == CardAnswerMode.Arab
              ? speech : Container(width: 0, height: 0,)
        ),
        isCorrect
            ? Positioned(
                bottom: 10.0,
                left: 10.0,
                child: GestureDetector(
                  onTap: () {
                    giveFeedback();
                  },
                  onLongPress: () {
                    giveFeedback();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: yellowColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.report, size: 20, color: whiteColor),
                        SmallerText(
                          text: 'Soal Salah?',
                          dark: false,
                          bold: true,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox(
                width: 0,
              ),
        !isCorrect
            ? Positioned(
                bottom: 10.0,
                left: 10.0,
                child: adsHint,
              )
            : const SizedBox(width: 0)
      ],
    );
  }
}
