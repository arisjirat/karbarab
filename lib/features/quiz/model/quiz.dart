import 'package:flutter/foundation.dart';
import 'package:karbarab/core/helper/log_printer.dart';
import 'package:karbarab/core/helper/utils.dart';

class QuizModel {
  final String id;
  final String arab;
  final String bahasa;
  final String image;
  final String voice;
  final CardCategory cardCategory;
  final int level;
  final DateTime date;

  QuizModel({
    @required this.id,
    @required this.arab,
    @required this.bahasa,
    @required this.cardCategory,
    @required this.level,
    @required this.voice,
    @required this.date,
    this.image = '',
  });

  Map<String, dynamic> toJson() {
    getLogger('cardCategory').e(cardCategory);
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['arab'] = arab;
    data['bahasa'] = bahasa;
    data['image'] = image;
    data['voice'] = voice;
    data['cardCategory'] = cardCategoryToString(cardCategory);
    data['voice'] = voice;
    data['date'] = date;
    return data;
  }
}
