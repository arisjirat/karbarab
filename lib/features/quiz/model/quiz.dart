import 'package:flutter/foundation.dart';

class QuizModel {
  final String id;
  final String arab;
  final String bahasa;
  final String image;
  final String arabVoice;
  final DateTime date;

  QuizModel({
    @required this.id,
    @required this.arab,
    @required this.bahasa,
    @required this.image,
    @required this.arabVoice,
    @required this.date,
  });
}
