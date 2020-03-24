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
  final Function getHint;

  CardImage({
    @required this.point,
    @required this.quiz,
    @required this.height,
    @required this.loading,
    @required this.isCorrect,
    @required this.adsLoaded,
    @required this.getHint,
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
                    getHint();
                  },
                  onLongPress: () {
                    getHint();
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
                        Container(
                          margin: const EdgeInsets.all(3.0),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.vpn_key, size: 20, color: greenColor),
                        ),
                        SmallerText(
                          text: 'Jawaban',
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
