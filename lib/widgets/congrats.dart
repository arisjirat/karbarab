import 'dart:math';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:karbarab/config/colors.dart';

class Congrats extends StatefulWidget {
  final bool play;

  Congrats({@required this.play});
  @override
  _CongratsState createState() => _CongratsState();
}

class _CongratsState extends State<Congrats> {
  // ConfettiController _controllerCenterRight;
  // ConfettiController _controllerCenterLeft;
  // ConfettiController _controllerTopCenter;
  ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    // _controllerCenterRight =
    //     ConfettiController(duration: Duration(seconds: 10));
    // _controllerCenterLeft = ConfettiController(duration: Duration(seconds: 10));
    // _controllerTopCenter = ConfettiController(duration: Duration(seconds: 10));
    _controllerBottomCenter = ConfettiController(
      duration: Duration(milliseconds: 100),
    );
    super.initState();
  }

  @override
  void dispose() {
    // _controllerCenterRight.dispose();
    // _controllerCenterLeft.dispose();
    // _controllerTopCenter.dispose();
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
      // emissionFrequency: 0.01,
      numberOfParticles: 30,
      // maxBlastForce: 100,
      // minBlastForce: 80,
      // blastDirection: 0, // radial value - RIGHT
      emissionFrequency: 0.6,
      minimumSize: const Size(5,
          5), // set the minimum potential size for the confetti (width, height)
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
    return Stack(
      children: <Widget>[
        // TOP CENTER
        // Align(
        //   alignment: Alignment.topCenter,
        //   child: ConfettiWidget(
        //     confettiController: _controllerTopCenter,
        //     blastDirection: pi / 2,
        //     maxBlastForce: 5,
        //     minBlastForce: 2,
        //     emissionFrequency: 0.05,
        //     numberOfParticles: 50,
        //     colors: [
        //       greenColor,
        //       greenColorLight,
        //       redColor,
        //       redColorLight,
        //       yellowColor,
        //       yellowColorDark,
        //     ],
        //   ),
        // ),
        // Align(
        //   alignment: Alignment.topCenter,
        //   child: FlatButton(
        //       onPressed: () {
        //         _controllerTopCenter.play();
        //       },
        //       child: _display('goliath')),
        // ),
        // BOTTOM CENTER
        Align(
          alignment: Alignment.bottomCenter,
          child: ConfettiWidget(
            confettiController: _controllerBottomCenter,
            blastDirection: -pi / 2,
            emissionFrequency: 0.01,
            numberOfParticles: 20,
            maxBlastForce: 100,
            minBlastForce: 80,
            colors: [
              greenColor,
              greenColorLight,
              redColor,
              redColorLight,
              yellowColor,
              yellowColorDark,
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FlatButton(
            onPressed: () {
              _controllerBottomCenter.play();
            },
            child: _display('hard and infrequent'),
          ),
        ),
      ],
    );
  }

  Text _display(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.black, fontSize: 20),
    );
  }
}
