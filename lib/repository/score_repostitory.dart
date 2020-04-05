import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/core/helper/utils.dart';
import 'package:karbarab/features/auth/model/user_model.dart';
import 'package:karbarab/features/global_scores/bloc/global_scores_bloc.dart';
import 'package:karbarab/features/quiz/model/quiz.dart';
import 'package:karbarab/utils/logger.dart';
import 'package:uuid/uuid.dart';

class BattleCardModel {
  final String scoreId;
  final String userId;
  final String userIdSender;
  final GameMode quizMode;
  final String quizId;
  final int targetScore;
  final int score;
  final QuizModel metaQuiz;
  final UserModel metaUser;
  DateTime createdAt;

  BattleCardModel({
    @required this.userId,
    @required this.userIdSender,
    @required this.quizMode,
    @required this.quizId,
    @required this.targetScore,
    @required this.score,
    @required this.metaQuiz,
    @required this.metaUser,
    this.scoreId,
    this.createdAt,
  });
}

class ScoreRepository {
  final CollectionReference scoreCollection =
      Firestore.instance.collection('scores');

  ScoreRepository();

  Future addScoreUser(
    String userId,
    GameMode quizMode,
    String quizId,
    int score,
    QuizModel metaQuiz,
    UserModel metaUser,
  ) async {
    try {
      final scoreId = Uuid().v4();
      return await scoreCollection.document(scoreId).setData({
        'scoreId': scoreId,
        'userId': userId,
        'quizId': quizId,
        'quizMode': gameModeToString(quizMode),
        'score': score,
        'metaUser': metaUser.toJson(),
        'metaQuiz': metaQuiz.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      Logger.e('AddUserScore', e: e, s: StackTrace.current);
    }
  }

  Future addBattleCard(BattleCardModel battleCard) async {
    try {
      final scoreId = Uuid().v4();
      return await scoreCollection.document(scoreId).setData({
        'scoreId': scoreId,
        'isBattle': true,
        'isSolved': false,
        'userIdSender': battleCard.userIdSender,
        'userId': battleCard.userId,
        'quizId': battleCard.quizId,
        'quizMode': gameModeToString(battleCard.quizMode),
        'score': 0,
        'targetScore': battleCard.targetScore,
        'metaUser': battleCard.metaUser.toJson(),
        'metaQuiz': battleCard.metaQuiz.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      Logger.e('AddBattleCard', e: e, s: StackTrace.current);
    }
  }

  Future updateBattleCard(String scoreId, score) async {
    try {
      final updateData = scoreCollection.document(scoreId).updateData;
      return await updateData({
        'isSolved': true,
        'score': score,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      Logger.e('AddBattleCard', e: e, s: StackTrace.current);
    }
  }

  Future<Iterable<DocumentSnapshot>> getUserScore(String id) async {
    try {
      final QuerySnapshot scores = await scoreCollection
        .where('userId', isEqualTo: id)
        .limit(10000)
        .getDocuments();
    return scores.documents;
    } catch (e) {
      Logger.e('GetUserScore', e: e, s: StackTrace.current);
      throw Exception;
    }
  }

  Future<List<ScoreGlobalModel>> getAllScore() async {
    final QuerySnapshot scores =
        await scoreCollection.limit(10000).getDocuments();
    final List<ScoreGlobalModel> grouped =
        scores.documents.fold([], (acc, cur) {
      final found = acc.indexWhere((e) => e.userId == cur['userId']);
      final metaUser = cur['metaUser'];
      final Timestamp timestamp = cur['createdAt'];
      final DateTime createdAt =
          Timestamp(timestamp.seconds, timestamp.nanoseconds).toDate();
      final String bahasa = cur['metaQuiz']['bahasa'];
      final GameMode quizMode = stringToGameMode(cur['quizMode']);
      final int score = cur['score'];
      final UserModel user = UserModel(
        id: metaUser['id'],
        email: metaUser['email'],
        avatar: metaUser['avatar'],
        fullname: metaUser['fullname'],
        username: metaUser['username'],
        isGoogleAuth: metaUser['isGoogleAuth'],
        tokenFCM: metaUser['tokenFCM'],
      );
      if (found >= 0) {
        acc[found] = ScoreGlobalModel(
          userId: user.id,
          metaUser: user,
          score: acc[found].score + cur['score'],
          scoreHistory: acc[found].scoreHistory,
        );
        acc[found].scoreHistory.add(ScoreItem(
              bahasa: bahasa,
              date: createdAt,
              score: score,
              mode: quizMode,
            ));
        return acc;
      }
      acc.add(ScoreGlobalModel(
        userId: user.id,
        metaUser: user,
        score: cur['score'],
        scoreHistory: [ScoreItem(
              bahasa: bahasa,
              date: createdAt,
              score: score,
              mode: quizMode)],
      ));
      return acc;
    });
    grouped.sort((a, b) => b.score.compareTo(a.score));
    return grouped;
  }
}
