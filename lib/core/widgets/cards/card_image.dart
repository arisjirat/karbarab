import 'package:flutter/material.dart';
import 'package:karbarab/core/helper/model_quiz.dart';
import 'package:karbarab/core/widgets/typography.dart';
import 'package:karbarab/core/config/colors.dart';

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
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
            decoration: const BoxDecoration(
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
