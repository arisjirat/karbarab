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
  final bool adsLoaded;
  final Function rewarded;

  CardImage({
    @required this.point,
    @required this.quiz,
    @required this.height,
    @required this.loading,
    @required this.isCorrect,
    @required this.adsLoaded,
    @required this.rewarded,
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
                  : Image.network(
                      quiz.image,
                      height: height - 120,
                      fit: BoxFit.fill,
                    )
            ],
          ),
        ),
        PointCard(point),
        (!isCorrect && adsLoaded)
            ? Positioned(
                bottom: 10.0,
                left: 10.0,
                child: GestureDetector(
                  onTap: () {
                    rewarded();
                  },
                  onLongPress: () {
                    rewarded();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.help_outline, size: 30, color: whiteColor),
                        SmallerText(
                          text: 'Bantuan',
                          dark: false,
                          bold: true,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(
                width: 0,
                height: 0,
              )
      ],
    );
  }
}
