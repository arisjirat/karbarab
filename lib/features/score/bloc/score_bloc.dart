import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karbarab/core/config/score_value.dart';

import 'package:karbarab/model/quiz.dart';
import 'package:karbarab/model/score.dart';
import 'package:karbarab/model/user.dart';
import 'package:karbarab/repository/quiz_repository.dart';
import 'package:karbarab/utils/logger.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:karbarab/repository/score_repostitory.dart';
import 'package:karbarab/repository/user_repository.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreQuiz {
  final double totalScore;
  final int totalAttempt;
  final double averageScore;
  final List<double> scores;
  final String quizId;
  final Quiz quiz;
  final GameMode quizMode;

  ScoreQuiz({
    @required this.quizId,
    @required this.totalScore,
    @required this.quiz,
    @required this.averageScore,
    @required this.scores,
    @required this.totalAttempt,
    @required this.quizMode,
  });
}

class ListScore {
  final List<DocumentSnapshot> scoreDocuments;
  final GameMode mode;

  ListScore({
    @required this.scoreDocuments,
    @required this.mode,
  });

  double get score {
    final double total = scoreFilter.fold(0, (t, e) => e[SCORE] + t);
    final int scoreLength = scoreFilter.isNotEmpty ? scoreFilter.length : 1;
    return (total / scoreLength / SCORE_BASE) * 10;
  }

  List<DocumentSnapshot> get scoreFilter {
    return scoreDocuments
        .where((e) => e[QUIZ_MODE] == GameModeHelper.stringOf(mode))
        .where((s) => !s[IS_BATTLE])
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
    } else if (event is DirtyBattle) {
      yield* _mapDirtyScore(event.score);
    } else if (event is SolvedBattle) {
      yield* _mapSolvedBattleScore(event.battleQuiz, event.score);
    }
  }

  Stream<ScoreState> _mapSolvedBattleScore(
    Score scoreBattle,
    double score,
  ) async* {
    try {
      yield SolvedBattleState(true, false);
      await _scoreRepository.updateBattleCard(scoreBattle.scoreId, score);
      yield SolvedBattleState(false, true);
    } catch (e) {
      Logger.e('AddUserScore', e: e, s: StackTrace.current);
      yield SolvedBattleState(false, true);
    }
  }

  Stream<ScoreState> _mapDirtyScore(Score score) async* {
    await _scoreRepository.dirtyBattleCard(score.scoreId);
  }

  Stream<ScoreState> _mapGetSummaryUserQuizScore() async* {
    final _id = await _userRepository.getUserId();
    final List<List<ScoreQuiz>> _userScores =
        await _scoreRepository.getUserScoreGoodOrBadQuiz(_id);
    yield SummaryUserScore(badQuiz: _userScores[0], goodQuiz: _userScores[1]);
  }

  Stream<ScoreState> _mapGetScoreUserByMode() async* {
    yield HasScore(
      scoreArabGambar: 0,
      scoreGambarArab: 0,
      scoreArabKata: 0,
      scoreKataArab: 0,
      loadScore: true,
    );
    final _userId = await _userRepository.getUserId();
    final _userScores = await _scoreRepository.getUserScore(_userId);
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
      GameMode quizMode, String quizId, double score, Quiz metaQuiz) async* {
    final User user = await _userRepository.getUserMeta();
    try {
      _scoreRepository.addScoreUser(
          user.id, quizMode, quizId, score, metaQuiz, user);
    } catch (e) {
      Logger.e('AddUserScore', e: e, s: StackTrace.current);
    }
  }
}
