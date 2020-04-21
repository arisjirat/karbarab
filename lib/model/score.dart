library score;

import 'package:built_value/built_value.dart';
import 'package:karbarab/model/quiz.dart';
import 'package:karbarab/model/user.dart';

part 'score.g.dart';

const SCORE_ID = 'scoreId';
const SCORE = 'score';
const QUIZ_ID = 'quizId';
const QUIZ_MODE = 'quizMode';
const CREATED_AT = 'createdAt';
const UPDATED_AT = 'updatedAt';
const TARGET_SCORE = 'targetScore';
const USER_ID = 'userId';
const USER_ID_SENDER = 'userIdSender';
const USER_AVATAR_SENDER = 'userAvatarSender';
const USERNAME_SENDER = 'usernameSender';
const USER_FCMTOKEN_SENDER = 'userFCMSender';
const META_USER = 'metaUser';
const META_QUIZ = 'metaQuiz';
const IS_SOLVED = 'isSolved';
const IS_BATTLE = 'isBattle';

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

  @nullable
  double get score;

  String get scoreId;

  @nullable
  double get targetScore;

  String get userId;

  @nullable
  String get userIdSender;

  @nullable
  String get userAvatarSender;

  @nullable
  String get usernameSender;

  @nullable
  String get userTokenSender;

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
