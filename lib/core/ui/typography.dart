import 'package:flutter/material.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/helper/scale_calculator.dart';

class LogoText extends StatelessWidget {
  final String text;
  final bool dark;
  final Color color;

  LogoText({@required this.text, this.dark = true, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'FTF-Ahlan',
        color: color == null ? color : dark ? textColor : whiteColor,
        // fontSize: 50.0,
        fontSize: scaleCalculator(50, context),
      ),
    );
  }
}

class ArabicText extends StatelessWidget {
  final String text;
  final bool dark;
  ArabicText({@required this.text, this.dark});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Geeza',
        color: dark ? textColor : whiteColor,
        // fontSize: 25.0,
        fontSize: scaleCalculator(25, context),
      ),
    );
  }
}

class BiggerArabicText extends StatelessWidget {
  final String text;
  final bool dark;
  final bool bold;
  BiggerArabicText({@required this.text, this.dark, this.bold = false});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Geeza',
        color: dark ? textColor : whiteColor,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        // fontSize: 60.0,
        fontSize: scaleCalculator(60, context),
      ),
    );
  }
}

class RegularText extends StatelessWidget {
  final String text;
  final bool dark;
  RegularText({@required this.text, this.dark = true});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: dark ? textColor : whiteColor,
        // fontSize: 20.0,
        fontSize: scaleCalculator(20, context),
      ),
    );
  }
}

class SmallerText extends StatelessWidget {
  final String text;
  final bool dark;
  final bool bold;
  SmallerText({@required this.text, this.dark, this.bold = false});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: dark ? textColor : whiteColor,
        // fontSize: 15.0,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        fontSize: scaleCalculator(15, context),
      ),
    );
  }
}

class BoldRegularText extends StatelessWidget {
  final String text;
  final bool dark;
  final Color color;
  BoldRegularText({@required this.text, this.dark = true, this.color});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color != null ? color : dark ? textColor : whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: scaleCalculator(20, context),
      ),
    );
  }
}

class LargerText extends StatelessWidget {
  final String text;
  final bool dark;
  final bool bold;
  LargerText({@required this.text, this.dark, this.bold = false});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: dark ? textColor : whiteColor,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        fontSize: scaleCalculator(35, context),
      ),
    );
  }
}

class BiggerText extends StatelessWidget {
  final String text;
  final bool dark;
  final bool bold;
  BiggerText({@required this.text, this.dark, this.bold = false});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: dark ? textColor : whiteColor,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        fontSize: scaleCalculator(25, context),
      ),
    );
  }
}
