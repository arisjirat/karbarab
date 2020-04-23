import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karbarab/core/config/score_value.dart';
import 'package:karbarab/features/score/bloc/score_bloc.dart';
import 'package:karbarab/model/quiz.dart';
import 'package:karbarab/model/score.dart';
import 'package:karbarab/model/user.dart';
import 'package:karbarab/repository/notification_repository.dart';
import 'package:karbarab/repository/quiz_repository.dart';
import 'package:karbarab/repository/user_repository.dart';

import 'package:karbarab/features/global_scores/bloc/global_scores_bloc.dart';
import 'package:karbarab/utils/logger.dart';
import 'package:uuid/uuid.dart';

class ScoreRepository {
  final CollectionReference scoreCollection =
      Firestore.instance.collection('scores');
  final NotificationRepository _notificationRepository = NotificationRepository();

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
        ..isBattle = document[IS_BATTLE]
        ..isSolved = document[IS_SOLVED]
        ..userId = document[USER_ID]
        ..userIdSender = document[USER_ID_SENDER]
        ..userTokenSender = document[USER_FCMTOKEN_SENDER]
        ..userAvatarSender = document[USER_AVATAR_SENDER]
        ..userSenderScore = document[USER_SENDER_SCORE]
        ..usernameSender = document[USERNAME_SENDER]
        ..metaUser = UserRepository.fromDoc(document[META_USER]).toBuilder()
        ..metaQuiz = QuizRepository.fromDoc(document[META_QUIZ]).toBuilder(),
    );
  }

  static Score fromJson(Map<String, dynamic> json) {
    return Score((s) => s
      ..scoreId = json[SCORE_ID]
      ..score = json[SCORE]
      ..quizId = json[QUIZ_ID]
      ..quizMode = GameModeHelper.valueOf(json[QUIZ_MODE])
      ..createdAt = DateTime.fromMillisecondsSinceEpoch(
          (json[CREATED_AT] as Timestamp).seconds * 1000)
      ..updatedAt = json[UPDATED_AT] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (json[UPDATED_AT] as Timestamp).seconds * 1000)
          : null
      ..targetScore = json[TARGET_SCORE]
      ..userId = json[USER_ID]
      ..isBattle = json[IS_BATTLE]
      ..isSolved = json[IS_SOLVED]
      ..userIdSender = json[USER_ID_SENDER]
      ..userTokenSender = json[USER_FCMTOKEN_SENDER]
      ..userAvatarSender = json[USER_AVATAR_SENDER]
      ..userSenderScore = json[USER_SENDER_SCORE]
      ..usernameSender = json[USERNAME_SENDER]
      ..metaUser = UserRepository.fromJson(json[META_USER]).toBuilder()
      ..metaQuiz = QuizRepository.fromJson(json[META_QUIZ]).toBuilder());
  }

  static Map<String, dynamic> toMap(Score score) {
    return {
      SCORE_ID: score.scoreId,
      SCORE: score.score.toDouble(),
      QUIZ_ID: score.quizId,
      QUIZ_MODE: GameModeHelper.stringOf(score.quizMode),
      CREATED_AT: score.createdAt,
      UPDATED_AT: score.updatedAt,
      TARGET_SCORE: score.targetScore.toDouble(),
      USER_ID: score.userId,
      IS_BATTLE: score.isBattle,
      IS_SOLVED: score.isSolved,
      USER_ID_SENDER: score.userIdSender,
      USER_FCMTOKEN_SENDER: score.userTokenSender,
      USER_AVATAR_SENDER: score.userAvatarSender,
      USER_SENDER_SCORE: score.userSenderScore,
      USERNAME_SENDER: score.usernameSender,
      META_USER: UserRepository.toMap(score.metaUser),
      META_QUIZ: QuizRepository.toMap(score.metaQuiz),
    };
  }

  ScoreRepository();

  Future addScoreUser(
    String userId,
    GameMode quizMode,
    String quizId,
    double score,
    Quiz metaQuiz,
    User metaUser,
  ) async {
    try {
      final scoreId = Uuid().v4();
      return await scoreCollection.document(scoreId).setData({
        SCORE_ID: scoreId,
        SCORE: score.toDouble(),
        QUIZ_ID: quizId,
        QUIZ_MODE: GameModeHelper.stringOf(quizMode),
        CREATED_AT: FieldValue.serverTimestamp(),
        UPDATED_AT: FieldValue.serverTimestamp(),
        TARGET_SCORE: SCORE_BASE.toDouble(),
        USER_ID: userId,
        USER_ID_SENDER: null,
        META_USER: UserRepository.toMap(metaUser),
        META_QUIZ: QuizRepository.toMap(metaQuiz),
        USER_SENDER_SCORE: null,
        IS_SOLVED: true,
        IS_BATTLE: false,
      });
    } catch (e) {
      Logger.e('AddUserScore ${GameModeHelper.stringOf(quizMode)}',
          e: e, s: StackTrace.current);
    }
  }

  Future addBattleCard(
      User user, Quiz quiz, GameMode mode, User userSender) async {
    try {
      final scoreId = Uuid().v4();
      await scoreCollection.document(scoreId).setData({
        SCORE_ID: scoreId,
        SCORE: null,
        QUIZ_ID: quiz.id,
        QUIZ_MODE: GameModeHelper.stringOf(mode),
        CREATED_AT: FieldValue.serverTimestamp(),
        UPDATED_AT: null,
        TARGET_SCORE: SCORE_TARGET_BATTLE,
        USER_ID: user.id,
        USER_ID_SENDER: userSender.id,
        USER_FCMTOKEN_SENDER: userSender.tokenFCM,
        USER_AVATAR_SENDER: userSender.avatar,
        USERNAME_SENDER: userSender.username,
        USER_SENDER_SCORE: null,
        META_USER: UserRepository.toMap(user),
        META_QUIZ: QuizRepository.toMap(quiz),
        IS_SOLVED: false,
        IS_BATTLE: true,
      });
      return scoreId;
    } catch (e) {
      Logger.e('AddBattleCard', e: e, s: StackTrace.current);
    }
  }

  Future dirtyBattleCard(Score battle) async {
    try {
      final updateData = scoreCollection.document(battle.scoreId).updateData;
      final targetScore = battle.targetScore;
      await updateData({
        IS_SOLVED: true,
        SCORE: -(targetScore / 2),
        USER_SENDER_SCORE: targetScore,
        UPDATED_AT: FieldValue.serverTimestamp(),
      });
      return;
    } catch (e) {
      Logger.e('DirtyBattleCard', e: e, s: StackTrace.current);
    }
  }

  Future updateBattleCard(Score battle, double score) async {
    try {
      final updateData = scoreCollection.document(battle.scoreId).updateData;
      await updateData({
        IS_SOLVED: true,
        SCORE: battle.targetScore == score ? battle.targetScore : -(battle.targetScore / 2),
        USER_SENDER_SCORE:
            battle.targetScore == score ? -(battle.targetScore / 2) : battle.targetScore,
        UPDATED_AT: FieldValue.serverTimestamp(),

      });
      return await _notificationRepository.answerNotification(battle, score);
    } catch (e) {
      Logger.e('UpdateBattleCard', e: e, s: StackTrace.current);
    }
  }

  Future<DocumentSnapshot> getSingleScore(String scoreId) async {
    try {
      final getSingleData = await scoreCollection.document(scoreId).get();
      return getSingleData;
    } catch (e) {
      Logger.e('Get Single Score', e: e, s: StackTrace.current);
      throw Exception('Faild get single score');
    }
  }

  Future<List<Score>> getAllBattleCard(String userId) async {
    try {
      final getAllData = (await scoreCollection
          // .where(USER_ID_SENDER, isEqualTo: userId)
          .where(USER_ID, isEqualTo: userId)
          .where(IS_BATTLE, isEqualTo: true)
          // .where(IS_SOLVED, isEqualTo: false)
          .limit(10000)
          .orderBy(CREATED_AT, descending: true)
          .getDocuments()).documents;
      final getAllDataSender = (await scoreCollection
          .where(USER_ID_SENDER, isEqualTo: userId)
          .where(IS_BATTLE, isEqualTo: true)
          // .where(IS_SOLVED, isEqualTo: false)
          .limit(10000)
          .orderBy(CREATED_AT, descending: true)
          .getDocuments()).documents;
      getAllData.addAll(getAllDataSender);
      final documents = getAllData;
      final List<Score> listData = documents.fold([], (a, c) {
        a.add(fromJson(c.data));
        return a;
      });
      listData.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return listData;
    } catch (e) {
      Logger.e('Get Battle caard', e: e, s: StackTrace.current);
      throw Exception('Faild get all battle card');
    }
  }

  Future<List<Score>> getAllBattleCardUnSolved(String userId) async {
    try {
      final getAllData = await scoreCollection
          .where(USER_ID, isEqualTo: userId)
          .where(IS_BATTLE, isEqualTo: true)
          .where(IS_SOLVED, isEqualTo: false)
          .limit(10000)
          .getDocuments();
      final documents = getAllData.documents;
      final List<Score> listData = documents.fold([], (a, c) {
        a.add(fromJson(c.data));
        return a;
      });
      return listData;
    } catch (e) {
      Logger.e('Get Battle caard', e: e, s: StackTrace.current);
      throw Exception('Faild get all battle card');
    }
  }

  Future<Iterable<DocumentSnapshot>> getUserScore(String id) async {
    try {
      final QuerySnapshot scores = await scoreCollection
          .where(USER_ID, isEqualTo: id)
          .where(IS_SOLVED, isEqualTo: true)
          .limit(10000)
          .getDocuments();
      return scores.documents;
    } catch (e) {
      Logger.e('GetUserScore', e: e, s: StackTrace.current);
      throw Exception;
    }
  }

  Future<Iterable<DocumentSnapshot>> getUserScoreWithoutBattle(String id) async {
    try {
      final QuerySnapshot scores = await scoreCollection
          .where(USER_ID, isEqualTo: id)
          .where(IS_BATTLE, isEqualTo: false)
          .limit(10000)
          .getDocuments();
      return scores.documents;
    } catch (e) {
      Logger.e('GetUserScore', e: e, s: StackTrace.current);
      throw Exception;
    }
  }

  Future<Iterable<DocumentSnapshot>> getUserScoreSender(String id) async {
    try {
      final QuerySnapshot scores = await scoreCollection
          .where(USER_ID_SENDER, isEqualTo: id)
          .where(IS_BATTLE, isEqualTo: true)
          .where(IS_SOLVED, isEqualTo: true)
          .limit(10000)
          .getDocuments();
      return scores.documents;
    } catch (e) {
      Logger.e('GetUserScore', e: e, s: StackTrace.current);
      throw Exception;
    }
  }

  Future<List<List<ScoreQuiz>>> getUserScoreGoodOrBadQuiz(String id) async {
    try {
      final QuerySnapshot scores = await scoreCollection
          .where(USER_ID, isEqualTo: id)
          .where(IS_BATTLE, isEqualTo: false)
          .limit(10000)
          .getDocuments();
      final Iterable<DocumentSnapshot> documents = scores.documents;

      final List<ScoreQuiz> summaryQuiz = documents.fold(
        [],
        (acc, cur) {
          final Map<String, dynamic> data = Map<String, dynamic>.from(cur.data);
          final found = acc.indexWhere((e) => e.quizId == data[QUIZ_ID]);
          final String quizId = data[QUIZ_ID];
          final int totalAttempt = 1;
          final GameMode quizMode = GameModeHelper.valueOf(data[QUIZ_MODE]);
          final Quiz quiz = QuizRepository.fromJson(data[META_QUIZ]);
          final double totalScore = data[SCORE];
          final List<double> scores = [data[SCORE]];
          if (found >= 0) {
            acc[found].scores.add(data[SCORE]);
            final double totalScoreSum = acc[found].totalScore + data[SCORE];
            acc[found] = ScoreQuiz(
              quizId: quizId,
              totalAttempt: totalAttempt + 1,
              averageScore:
                  totalScoreSum / (SCORE_BASE * acc[found].scores.length),
              quiz: quiz,
              quizMode: quizMode,
              totalScore: totalScoreSum,
              scores: acc[found].scores,
            );
            return acc;
          }
          acc.add(ScoreQuiz(
            quizId: quizId,
            totalAttempt: totalAttempt,
            quiz: quiz,
            quizMode: quizMode,
            averageScore: totalScore / (SCORE_BASE * 1),
            totalScore: totalScore,
            scores: scores,
          ));
          return acc;
        },
      );

      final List<ScoreQuiz> badQuiz =
          summaryQuiz.where((e) => e.averageScore <= 0.75).toList();
      final List<ScoreQuiz> goodQuiz =
          summaryQuiz.where((e) => e.averageScore > 0.75).toList();

      return [badQuiz, goodQuiz];
    } catch (e) {
      Logger.e('GetUserScore', e: e, s: StackTrace.current);
      throw Exception;
    }
  }

  Future<List<ScoreGlobalModel>> getAllScore() async {
    final QuerySnapshot scores = await scoreCollection
        .limit(10000)
        .where(IS_SOLVED, isEqualTo: true)
        .orderBy(CREATED_AT,descending: true)
        .getDocuments();

    List<ScoreGlobalModel> reconstruct(List<ScoreGlobalModel> acc, cur) {
      final Map<String, dynamic> data = Map<String, dynamic>.from(cur.data);
      final int found = acc.indexWhere((e) => e.userId == data[USER_ID]);
      final User user = UserRepository.fromJson(data[META_USER]);
      if (found >= 0) {
        final double score = acc[found].score.toDouble() + data[SCORE];
        acc[found] = ScoreGlobalModel(
          userId: user.id,
          metaUser: user,
          score: score,
          scoreHistory: acc[found].scoreHistory,
        );
        acc[found].scoreHistory.add(fromJson(data));
        return acc;
      }
      acc.add(ScoreGlobalModel(
        userId: user.id,
        metaUser: user,
        score: data[SCORE],
        scoreHistory: [fromJson(data)],
      ));
      return acc;
    }

    final List<ScoreGlobalModel> grouped =
        scores.documents.fold([], reconstruct);
      final List<ScoreGlobalModel> added = grouped.map((ScoreGlobalModel g) {
      final filteredScores = scores.documents
          .where((s) => s.data[USER_ID_SENDER] == g.userId)
          .map((s) => s.data[USER_SENDER_SCORE])
          .toList()
          .fold(0, (acc, cur) => acc + cur);
      final List<Score> filteredHistory = scores.documents
          .where((s) => s.data[USER_ID_SENDER] == g.userId)
          .map((s) => fromJson(s.data))
          .toList();
      g.scoreHistory.addAll(filteredHistory);
      return ScoreGlobalModel(
        metaUser: g.metaUser,
        scoreHistory: g.scoreHistory,
        score: g.score + filteredScores,
        userId: g.userId,
      );
    }).toList();
    added.sort((a, b) => b.score.compareTo(a.score));

    return added;
  }
}
