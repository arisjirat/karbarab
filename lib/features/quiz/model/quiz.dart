import 'package:flutter/foundation.dart';
import 'package:karbarab/core/helper/utils.dart';

class QuizModel {
  String id;
  String arab;
  String bahasa;
  String image;
  String voice;
  CardCategory cardCategory;
  int level;
  DateTime date;

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

  QuizModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arab = json['arab'];
    bahasa = json['bahasa'];
    image = json['image'];
    voice = json['voice'];
    cardCategory = stringToCardCategory(json['cardCategory']);
    level = json['level'];
    date = DateTime.now();
  }

  Map<String, dynamic> toJson() {
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
