import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karbarab/model/user.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/core/helper/utils.dart';

import 'package:karbarab/features/global_scores/bloc/global_scores_bloc.dart';
import 'package:karbarab/features/quiz/model/quiz.dart';
import 'package:karbarab/utils/logger.dart';
import 'package:uuid/uuid.dart';

class BattleCardModel {
  String scoreId;
  String userId;
  String userIdSender;
  GameMode quizMode;
  String quizId;
  int targetScore;
  int score;
  QuizModel metaQuiz;
  User metaUser;
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

  BattleCardModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userIdSender = json['userIdSender'];
    quizMode = stringToGameMode(json['quizMode']);
    quizId = json['quizId'];
    targetScore = json['targetScore'];
    score = json['score'];
    metaQuiz = QuizModel.fromJson(json['metaQuiz']);
    metaUser = UserRepository.fromDoc(json['metaUser']);
    scoreId = json['scoreId'];
    createdAt = DateTime.fromMicrosecondsSinceEpoch(json['createdAt'] * 1000);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = userId;
    data['userIdSender'] = userIdSender;
    data['quizMode'] = quizMode;
    data['quizId'] = quizId;
    data['targetScore'] = targetScore;
    data['score'] = score;
    data['metaQuiz'] = metaQuiz;
    data['metaUser'] = metaUser;
    data['scoreId'] = scoreId;
    data['createdAt'] = createdAt;
    return data;
  }
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
    User metaUser,
  ) async {
    try {
      final scoreId = Uuid().v4();
      return await scoreCollection.document(scoreId).setData({
        'scoreId': scoreId,
        'userId': userId,
        'quizId': quizId,
        'quizMode': gameModeToString(quizMode),
        'score': score,
        'metaUser': UserRepository.toMap(metaUser),
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
      await scoreCollection.document(scoreId).setData({
        'scoreId': scoreId,
        'isBattle': true,
        'isSolved': false,
        'userIdSender': battleCard.userIdSender,
        'userId': battleCard.userId,
        'quizId': battleCard.quizId,
        'quizMode': gameModeToString(battleCard.quizMode),
        'score': 0,
        'targetScore': battleCard.targetScore,
        'metaUser': UserRepository.toMap(battleCard.metaUser),
        'metaQuiz': battleCard.metaQuiz.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      return scoreId;
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

  Future readStateBattleCard(String scoreId) async {
    try {
      final updateData = scoreCollection.document(scoreId).updateData;
      return await updateData({
        'isSolved': true,
      });
    } catch (e) {
      Logger.e('AddBattleCard', e: e, s: StackTrace.current);
    }
  }

  Future<DocumentSnapshot> getSingleScore(String scoreId) async {
    try {
      final getSingleData = await scoreCollection.document('3537bae3-fcd5-4d33-a624-c50641d87944').get();
      Logger.w('Get Single Score ${scoreId},');
      return getSingleData;
    } catch (e) {
      Logger.e('Get Single Score', e: e, s: StackTrace.current);
      throw Exception('Faild get single score');
    }
  }

  Future<Iterable<DocumentSnapshot>> getAllBattleCard(String userId) async {
    try {
      final getAllData = await scoreCollection
        .where('userId', isEqualTo: userId)
        .where('isBattle', isEqualTo: true )
        .where('isSolved', isEqualTo: false )
        .limit(10000)
        .getDocuments();
      return getAllData.documents;
    } catch (e) {
      Logger.e('Get Battle caard', e: e, s: StackTrace.current);
      throw Exception('Faild get all battle card');
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
      final User user = UserRepository.fromDoc(metaUser);
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
