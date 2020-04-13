library score;

import 'package:built_value/built_value.dart';
import 'package:karbarab/model/quiz.dart';
import 'package:karbarab/model/user.dart';

part 'score.g.dart';

abstract class Score implements Built<Score, ScoreBuilder> {
  DateTime get createdAt;
  @nullable
  DateTime get updatedAt;

  bool get isBattle;

  bool get isSolved;

  Quiz get metaQuiz;

  User get metaUser;

  String get quizId;

  GameMode get quizMode;

  int get score;

  String get scoreId;

  int get targetScore;

  String get userId;

  @nullable
  String get userSenderId;

  factory Score([updates(ScoreBuilder b)]) = _$Score;
  Score._();

}

enum GameMode {
  GambarArab,
  ArabGambar,
  KataArab,
  ArabKata,
}

class GameModeHelper {
  static String stringOf(GameMode gameMode) {
    switch (gameMode) {
      case GameMode.GambarArab:
        return 'GambarArab';
      case GameMode.ArabGambar:
        return 'ArabGambar';
      case GameMode.KataArab:
        return 'KataArab';
      default:
        return 'ArabKata';
    }
  }

  static GameMode valueOf(String string) {
    switch (string) {
      case 'GambarArab':
        return GameMode.GambarArab;
      case 'ArabGambar':
        return GameMode.ArabGambar;
      case 'KataArab':
        return GameMode.KataArab;
      default:
        return GameMode.ArabKata;
    }
  }
}

enum CardAnswerMode {
  Arab,
  Latin,
}

class CardAnswerModeHelper {
  static String stringOf(CardAnswerMode cardAnswerMode) {
    switch (cardAnswerMode) {
      case CardAnswerMode.Arab:
        return 'Arab';
      case CardAnswerMode.Latin:
        return 'Latin';
      default:
        return 'Latin';
    }
  }

  static CardAnswerMode valueOf(String string) {
    switch (string) {
      case 'Arab':
        return CardAnswerMode.Arab;
      case 'Latin':
        return CardAnswerMode.Latin;
      default:
        return CardAnswerMode.Latin;
    }
  }
}
