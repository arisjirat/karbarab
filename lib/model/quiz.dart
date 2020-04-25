library quiz;

import 'package:built_value/built_value.dart';

part 'quiz.g.dart';

abstract class Quiz implements Built<Quiz, QuizBuilder> {
  String get id;
  String get arab;
  String get bahasa;
  @nullable
  String get image;
  @nullable
  String get voice;
  CardCategory get cardCategory;
  int get level;
  DateTime get date;

  factory Quiz([updates(QuizBuilder b)]) = _$Quiz;
  Quiz._();

}

enum CardCategory { Animal, Plant, Fruit, Object }

class CardCategoryHelper {
  static String stringOf(CardCategory messageType) {
    switch (messageType) {
      case CardCategory.Animal:
        return 'Animal';
      case CardCategory.Plant:
        return 'Plant';
      case CardCategory.Fruit:
        return 'Fruit';
      default:
        return 'Object';
    }
  }

  static CardCategory valueOf(String string) {
    switch (string) {
      case 'Animal':
        return CardCategory.Animal;
      case 'Plant':
        return CardCategory.Plant;
      case 'Fruit':
        return CardCategory.Fruit;
      default:
        return CardCategory.Object;
    }
  }
}