import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/core/config/score_value.dart';
import 'package:karbarab/core/helper/utils.dart';
import 'package:karbarab/features/auth/model/user_model.dart';
import 'package:karbarab/features/quiz/model/quiz.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:karbarab/repository/score_repostitory.dart';
import 'package:karbarab/repository/user_repository.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreQuizModel {
  final int totalScore;
  final int totalAttempt;
  final double averageScore;
  final List<int> scores;
  final String quizId;
  final QuizModel quiz;
  final GameMode quizMode;

  ScoreQuizModel({
    @required this.quizId,
    @required this.totalScore,
    @required this.quiz,
    @required this.averageScore,
    @required this.scores,
    @required this.totalAttempt,
    @required this.quizMode,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['totalScore'] = totalScore;
    data['totalAttempt'] = totalAttempt;
    data['averageScore'] = averageScore;
    data['scores'] = scores;
    data['quizId'] = quizId;
    data['quiz'] = quiz;
    data['quizMode'] = quizMode;
    return data;
  }

}

class ListScore {
  final List<DocumentSnapshot> scoreDocuments;
  final GameMode mode;

  ListScore({
    @required this.scoreDocuments,
    @required this.mode,
  });

  double get score {
    final int total = scoreFilter.fold(0, (t, e) => e['score'] + t);
    final int scoreLength = scoreFilter.isNotEmpty ? scoreFilter.length : 1;
    return (total / scoreLength / SCORE_BASE) * 10;
  }

  List<DocumentSnapshot> get scoreFilter {
    return scoreDocuments
        .where((e) => e['quizMode'] == gameModeToString(mode))
        .toList();
  }
}

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  final ScoreRepository _scoreRepository = ScoreRepository();
  final UserRepository _userRepository = UserRepository();
  @override
  ScoreState get initialState => HasScore(
        scoreGambarArab: 0,
        scoreArabGambar: 0,
        scoreArabKata: 0,
        scoreKataArab: 0,
        loadScore: true,
      );

  @override
  Stream<ScoreState> mapEventToState(
    ScoreEvent event,
  ) async* {
    if (event is GetScoreUserByMode) {
      yield* _mapGetScoreUserByMode();
    } else if (event is AddScoreUser) {
      yield* _mapAddUserScore(
          event.mode, event.quizId, event.score, event.metaQuiz);
    } else if (event is GetSummaryUserQuizScore) {
      yield* _mapGetSummaryUserQuizScore();
    }
  }

  Stream<ScoreState> _mapGetSummaryUserQuizScore() async* {
    final _email = await _userRepository.getEmail();
    final _userScores = await _scoreRepository.getUserScore(_email);
    final List<ScoreQuizModel> summaryQuiz = _userScores.fold(
      [],
      (acc, cur) {
        final found = acc.indexWhere((e) => e.quizId == cur['quizId']);
        final Timestamp timestamp = cur['metaQuiz']['date'];
        final String quizId = cur['quizId'];
        final int totalAttempt = 1;
        final String id = cur['metaQuiz']['id'];
        final String arab = cur['metaQuiz']['arab'];
        final String bahasa = cur['metaQuiz']['bahasa'];
        final String image = cur['metaQuiz']['image'];
        final String arabVoice = cur['metaQuiz']['arabVoice'];
        final GameMode quizMode = stringToGameMode(cur['quizMode']);
        final DateTime date = Timestamp(timestamp.seconds, timestamp.nanoseconds).toDate();
        final int totalScore = cur['score'];
        final List<int> scores = [cur['score']];
        if (found >= 0) {
          acc[found].scores.add(cur['score']);
          final int totalScoreSum = acc[found].totalScore + cur['score'];
          acc[found] = ScoreQuizModel(
            quizId: quizId,
            totalAttempt: totalAttempt + 1,
            averageScore: totalScoreSum / (300 * acc[found].scores.length),
            quiz: QuizModel(
              id: id,
              arab: arab,
              bahasa: bahasa,
              image: image,
              arabVoice: arabVoice,
              date: date,
            ),
            quizMode: quizMode,
            totalScore: totalScoreSum,
            scores: acc[found].scores,
          );
          return acc;
        }
        acc.add(ScoreQuizModel(
          quizId: quizId,
          totalAttempt: totalAttempt,
          quiz: QuizModel(
            id: id,
            arab: arab,
            bahasa: bahasa,
            image: image,
            arabVoice: arabVoice,
            date: date,
          ),
          quizMode: quizMode,
          averageScore: totalScore / (SCORE_BASE * 1),
          totalScore: totalScore,
          scores: scores,
        ));
        return acc;
      },
    );

    final badQuiz = summaryQuiz.where((e) => e.averageScore <= 0.9).toList();
    final goodQuiz = summaryQuiz.where((e) => e.averageScore > 0.9).toList();

    yield SummaryUserScore(badQuiz: badQuiz, goodQuiz: goodQuiz);
  }

  Stream<ScoreState> _mapGetScoreUserByMode() async* {
    // loading
    yield HasScore(
      scoreArabGambar: 0,
      scoreGambarArab: 0,
      scoreArabKata: 0,
      scoreKataArab: 0,
      loadScore: true,
    );
    final _email = await _userRepository.getEmail();
    final _userScores = await _scoreRepository.getUserScore(_email);
    yield HasScore(
      scoreArabGambar: ListScore(
        mode: GameMode.ArabGambar,
        scoreDocuments: _userScores,
      ).score,
      scoreGambarArab: ListScore(
        mode: GameMode.GambarArab,
        scoreDocuments: _userScores,
      ).score,
      scoreArabKata: ListScore(
        mode: GameMode.ArabKata,
        scoreDocuments: _userScores,
      ).score,
      scoreKataArab: ListScore(
        mode: GameMode.KataArab,
        scoreDocuments: _userScores,
      ).score,
      loadScore: false,
    );
  }

  Stream<ScoreState> _mapAddUserScore(
      GameMode quizMode, String quizId, int score, QuizModel metaQuiz) async* {
    
    final UserModel user = await _userRepository.getUserMeta();
    try {
      _scoreRepository.addScoreUser(user.email, quizMode, quizId, score, metaQuiz, user);
    } catch (e) {
      print(e);
    }
    // yield ScoreAdded();
  }
}
