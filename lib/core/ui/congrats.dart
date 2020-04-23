import 'dart:math';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/config/score_value.dart';

class Congrats extends StatefulWidget {
  final bool play;
  final double point;

  Congrats({@required this.play,@required this.point});
  @override
  _CongratsState createState() => _CongratsState();
}

class _CongratsState extends State<Congrats> {
  ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    _controllerBottomCenter = ConfettiController(
      duration: const Duration(milliseconds: 100),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.play) {
      _controllerBottomCenter.play();
    }
    return ConfettiWidget(
      confettiController: _controllerBottomCenter,
      blastDirection: -pi / 2,
      numberOfParticles: widget.point >= SCORE_BASE ? 20 : widget.point >= 0.5 * SCORE_BASE ? 10 : 1,
      emissionFrequency: 0.6,
      minimumSize: const Size( 5, 5), // set the minimum potential size for the confetti (width, height)
      maximumSize: const Size(20, 20),
      shouldLoop: false,
      colors: [
        greenColor,
        greenColorLight,
        redColor,
        redColorLight,
        yellowColor,
        yellowColorDark,
      ],
    );
  }
}
