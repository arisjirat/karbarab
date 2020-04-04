import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/features/quiz/model/quiz.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/core/ui/cards/point.dart';

class CardImage extends StatelessWidget {
  final int point;
  final QuizModel quiz;
  final double height;
  final bool loading;
  final bool isCorrect;
  final Widget adsHint;
  final Function giveFeedback;

  CardImage({
    @required this.point,
    @required this.quiz,
    @required this.height,
    @required this.loading,
    @required this.isCorrect,
    @required this.adsHint,
    @required this.giveFeedback
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height - 80,
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loading || quiz == null
                  ? RegularText(text: 'Loading', dark: true)
                  : Image(
                          image: AssetImage('assets/quiz/${quiz.image}'),
                          height: height - 120,
                          fit: BoxFit.fill,
                        ),
            ],
          ),
        ),
        PointCard(point),
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
          : const SizedBox(width: 0,),
        !isCorrect
            ? Positioned(
                bottom: 10.0,
                left: 10.0,
                child: adsHint,
              )
            : Container(
                width: 0,
                height: 0,
              )
      ],
    );
  }
}
