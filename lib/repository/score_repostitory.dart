import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/core/helper/utils.dart';
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
}
