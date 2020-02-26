import 'package:flutter/material.dart';
import 'package:karbarab/config/colors.dart';

class LogoText extends StatelessWidget {
  final String text;
  final bool dark;

  LogoText({ @required this.text, this.dark });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'FTF-Ahlan',
        color: dark ? textColor : whiteColor,
        fontSize: 50.0),
    );
  }
}

class ArabicText extends StatelessWidget {
  final String text;
  final bool dark;
  ArabicText({ @required this.text, this.dark });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Geeza',
        color: dark ? textColor : whiteColor,
        fontSize: 25.0),
    );
  }
}

class RegularText extends StatelessWidget {
  final String text;
  final bool dark;
  RegularText({ @required this.text, this.dark });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: dark ? textColor : whiteColor,
        fontSize: 20.0),
    );
  }
}


class SmallerText extends StatelessWidget {
  final String text;
  final bool dark;
  SmallerText({ @required this.text, this.dark });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: dark ? textColor : whiteColor,
        fontSize: 15.0),
    );
  }
}

class BoldRegularText extends RegularText {
  final String text;
  final bool dark;
  BoldRegularText({ @required this.text, this.dark });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: dark ? textColor : whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 20.0),
    );
  }
}

class BiggerText extends StatelessWidget {
  final String text;
  final bool dark;
  BiggerText({ @required this.text, this.dark });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: dark ? textColor : whiteColor,
        fontSize: 25.0),
    );
  }
}

