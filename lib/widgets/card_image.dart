import 'package:flutter/material.dart';
import 'package:karbarab/helper/model_quiz.dart';
import 'package:karbarab/widgets/typography.dart';
import 'package:karbarab/config/colors.dart';

class CardImage extends StatelessWidget {
  final int point;
  final QuizModel quiz;
  final double height;
  final bool loading;

  CardImage({
    @required this.point,
    @required this.quiz,
    @required this.height,
    @required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            height: height - 40,
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loading || quiz == null
                    ? RegularText(text: 'Loading', dark: true)
                    : Image.network(quiz.image,
                        height: 150, fit: BoxFit.fill)
              ],
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: redColor,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: SmallerText(
                text: point.toString(),
                dark: false,
              ),
            ),
          ),
        ],
      );
  }
}
