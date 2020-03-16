import 'package:flutter/material.dart';
import 'package:karbarab/features/quiz/model/quiz.dart';
import 'package:karbarab/core/ui/typography.dart';
import 'package:karbarab/core/ui/cards/point.dart';

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
      ],
    );
  }
}
