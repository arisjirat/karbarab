import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/core/helper/log_printer.dart';
import 'package:karbarab/core/helper/utils.dart';
import 'package:karbarab/features/auth/model/user_model.dart';
import 'package:karbarab/features/global_scores/bloc/global_scores_bloc.dart';
import 'package:karbarab/features/quiz/model/quiz.dart';
import 'package:uuid/uuid.dart';

class ScoreRepository {
  final CollectionReference scoreCollection =
      Firestore.instance.collection('scores');

  ScoreRepository();

  Future addScoreUser(
    String email,
    GameMode quizMode,
    String quizId,
    int score,
    QuizModel metaQuiz,
    UserModel metaUser,
  ) async {
    try {
      return await scoreCollection.document(Uuid().v4()).setData({
        'userEmail': email,
        'quizId': quizId,
        'quizMode': gameModeToString(quizMode),
        'score': score,
        'metaUser': metaUser.toJson(),
        'metaQuiz': metaQuiz.toJson(),
        'createdAt': FieldValue.serverTimestamp()
      });
    } catch (e) {
      getLogger('AddUserScore').e(e);
    }
  }

  Future<Iterable<DocumentSnapshot>> getUserScore(String email) async {
    final QuerySnapshot scores = await scoreCollection
        .where('userEmail', isEqualTo: email)
        .limit(10000)
        .getDocuments();
    return scores.documents;
  }

  Future<List<ScoreGlobalModel>> getAllScore() async {
    final QuerySnapshot scores =
        await scoreCollection.limit(10000).getDocuments();
    final List<ScoreGlobalModel> grouped =
        scores.documents.fold([], (acc, cur) {
      final found = acc.indexWhere((e) => e.userMail == cur['userEmail']);
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
          metaUser: user,
          score: acc[found].score + cur['score'],
          userMail: user.email,
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
        metaUser: user,
        userMail: user.email,
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
