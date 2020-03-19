import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/core/helper/utils.dart';
import 'package:karbarab/features/global_scores/bloc/global_scores_bloc.dart';
import 'package:karbarab/features/quiz/model/quiz.dart';
import 'package:uuid/uuid.dart';

class ScoreRepository {
  final CollectionReference scoreCollection = Firestore.instance.collection('scores');

  ScoreRepository();

  Future addScoreUser(
    String email,
    GameMode quizMode,
    String quizId,
    int score,
    QuizModel metaQuiz,
  ) async {
    try {
      return await scoreCollection
        .document(Uuid().v4())
        .setData({
          'userEmail': email,
          'quizId': quizId,
          'quizMode': gameModeToString(quizMode),
          'score': score,
          'metaQuiz': metaQuiz.toJson(),
          'createdAt': FieldValue.serverTimestamp()
        });
    } catch (e) {
      print('error submit score:');
      print(e);
    }
  }

  Future<Iterable<DocumentSnapshot>> getUserScore(String email) async {
    final QuerySnapshot scores = await scoreCollection
      .where('userEmail', isEqualTo: email)
      .getDocuments();
    return scores.documents;
  }

  Future<List<ScoreGlobalModel>> getAllScore() async {
    final QuerySnapshot scores = await scoreCollection
      .getDocuments();
    final List<ScoreGlobalModel> grouped = scores.documents.fold([], (acc, cur) {
      final found = acc.indexWhere((e) => e.userMail == cur['userEmail']);
      if (found >= 0) {
        acc[found] = ScoreGlobalModel(cur['userEmail'], acc[found].score + cur['score']);
        // acc[found] = {
        //   'userEmail': cur['userEmail'],
        //   'score': acc[found].score + cur['score'],
        // };
        return acc;
      }
      acc.add(ScoreGlobalModel(cur['userEmail'], cur['score']));
      return acc;
    });
    print(grouped);
    return grouped;
  }
}
