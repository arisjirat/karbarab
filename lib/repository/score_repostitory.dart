import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karbarab/model/quiz.dart';
import 'package:karbarab/model/score.dart';
import 'package:karbarab/model/user.dart';
import 'package:karbarab/repository/quiz_repository.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:meta/meta.dart';

import 'package:karbarab/features/global_scores/bloc/global_scores_bloc.dart';
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
  Quiz metaQuiz;
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
    quizMode = GameModeHelper.valueOf(json['quizMode']);
    quizId = json['quizId'];
    targetScore = json['targetScore'];
    score = json['score'];
    metaQuiz = QuizRepository.fromDoc(json['metaQuiz']);
    metaUser = UserRepository.fromDoc(json['metaUser']);
    scoreId = json['scoreId'];
    createdAt = DateTime.fromMicrosecondsSinceEpoch(json['createdAt'] * 1000);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = userId;
    data['userIdSender'] = userIdSender;
    data['quizMode'] = GameModeHelper.stringOf(quizMode);
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

  static const SCORE_ID = 'scoreId';
  static const SCORE = 'score';
  static const QUIZ_ID = 'quizId';
  static const QUIZ_MODE = 'quizMode';
  static const CREATED_AT = 'createdAt';
  static const UPDATED_AT = 'updatedAt';
  static const TARGET_SCORE = 'targetScore';
  static const USER_ID = 'userId';
  static const USER_SENDER_ID = 'userSenderId';
  static const META_USER = 'metaUser';
  static const META_QUIZ = 'metaQuiz';

  static Score fromDoc(DocumentSnapshot document) {
    return Score(
      (u) => u
        ..scoreId = document[SCORE_ID]
        ..score = document[SCORE]
        ..quizId = document[QUIZ_ID]
        ..quizMode = GameModeHelper.valueOf(document[QUIZ_MODE])
        ..createdAt = document[CREATED_AT]
        ..updatedAt = document[UPDATED_AT]
        ..targetScore = document[TARGET_SCORE]
        ..userId = document[USER_ID]
        ..userSenderId = document[USER_SENDER_ID]
        ..metaUser = UserRepository.fromDoc(document[META_USER]).toBuilder()
        ..metaQuiz = QuizRepository.fromDoc(document[META_QUIZ]).toBuilder(),
    );
  }

  static Map<String, dynamic> toMap(Score score) {
    return {
      SCORE_ID: score.scoreId,
      SCORE: score.score,
      QUIZ_ID: score.quizId,
      QUIZ_MODE: GameModeHelper.stringOf(score.quizMode),
      CREATED_AT: score.createdAt,
      UPDATED_AT: score.updatedAt,
      TARGET_SCORE: score.targetScore,
      USER_ID: score.userId,
      USER_SENDER_ID: score.userSenderId,
      META_USER: UserRepository.toMap(score.metaUser),
      META_QUIZ: QuizRepository.toMap(score.metaQuiz),
    };
  }

  ScoreRepository();

  Future addScoreUser(
    String userId,
    GameMode quizMode,
    String quizId,
    int score,
    Quiz metaQuiz,
    User metaUser,
  ) async {
    try {
      final scoreId = Uuid().v4();
      return await scoreCollection.document(scoreId).setData({
        'scoreId': scoreId,
        'userId': userId,
        'quizId': quizId,
        'quizMode': GameModeHelper.stringOf(quizMode),
        'score': score,
        'metaUser': UserRepository.toMap(metaUser),
        'metaQuiz': QuizRepository.toMap(metaQuiz),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      Logger.e('AddUserScore ${GameModeHelper.stringOf(quizMode)}', e: e, s: StackTrace.current);
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
        'quizMode': GameModeHelper.stringOf(battleCard.quizMode),
        'score': 0,
        'targetScore': battleCard.targetScore,
        'metaUser': UserRepository.toMap(battleCard.metaUser),
        'metaQuiz': QuizRepository.toMap(battleCard.metaQuiz),
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
      final getSingleData = await scoreCollection
          .document('3537bae3-fcd5-4d33-a624-c50641d87944')
          .get();
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
          .where('isBattle', isEqualTo: true)
          .where('isSolved', isEqualTo: false)
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
      final Map<String, dynamic> data = Map<String, dynamic>.from(cur.data);
      final found = acc.indexWhere((e) => e.userId == data['userId']);
      final metaUser = data['metaUser'];
      final Timestamp timestamp = data['createdAt'];
      final DateTime createdAt =
          Timestamp(timestamp.seconds, timestamp.nanoseconds).toDate();
      final String bahasa = data['metaQuiz']['bahasa'];
      final GameMode quizMode = GameModeHelper.valueOf(data['quizMode']);
      final int score = data['score'];
      final User user = UserRepository.fromJson(metaUser);
      if (found >= 0) {
        acc[found] = ScoreGlobalModel(
          userId: user.id,
          metaUser: user,
          score: acc[found].score + data['score'],
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
        score: data['score'],
        scoreHistory: [
          ScoreItem(
              bahasa: bahasa, date: createdAt, score: score, mode: quizMode)
        ],
      ));
      return acc;
    });
    grouped.sort((a, b) => b.score.compareTo(a.score));
    return grouped;
  }
}
