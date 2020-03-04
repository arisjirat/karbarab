import 'package:flutter/material.dart';
import 'package:karbarab/helper/model_quiz.dart';
import 'package:karbarab/widgets/typography.dart';
import 'package:karbarab/config/colors.dart';

class CardArab extends StatefulWidget {
  final int point;
  final QuizModel quiz;
  final double height;
  final bool loading;

  CardArab({
    @required this.point,
    @required this.quiz,
    @required this.height,
    @required this.loading,
  });

  @override
  _CardArabState createState() => _CardArabState();
}

class _CardArabState extends State<CardArab> {

  @override
  void initState() {
    super.initState();
  }

  void _play() {
    // assetsAudioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: widget.height - 40,
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.loading
                  ? RegularText(text: 'Loading', dark: true)
                  : BiggerArabicText(
                      text: widget.quiz.arab,
                      dark: true,
                      bold: true,
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
            decoration: BoxDecoration(
              color: redColor,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: SmallerText(
              text: widget.point.toString(),
              dark: false,
            ),
          ),
        ),
        Positioned(
          top: 20.0,
          right: 20.0,
          child: GestureDetector(
            onTap: _play,
            child: Icon(
              Icons.volume_up,
              color: greyColorLight,
              size: 40.0,
            ),
          ),
        ),
      ],
    );
  }
}
