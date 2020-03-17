import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/core/helper/utils.dart';
import 'package:karbarab/features/quiz/model/quiz.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:karbarab/repository/score_repostitory.dart';
import 'package:karbarab/repository/user_repository.dart';

part 'score_event.dart';
part 'score_state.dart';

class ListScore {
  final Iterable<DocumentSnapshot> scoreDocuments;
  final GameMode mode;

  ListScore({
    @required this.scoreDocuments,
    @required this.mode,
  });

  double get score {
    return ((scoreFilter.fold(0, (t, e) => e['score'] + t) /
                scoreFilter.length) /
            300) *
        10;
  }

  Iterable<DocumentSnapshot> get scoreFilter {
    return scoreDocuments.where((e) => e['quizMode'] == gameModeToString(mode));
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
      yield* _mapGetScoreUserByMode(event.mode);
    } else if (event is AddScoreUser) {
      yield* _mapAddUserScore(
          event.mode, event.quizId, event.score, event.metaQuiz);
    }
  }

  Stream<ScoreState> _mapGetScoreUserByMode(mode) async* {
    final currentState = state;
    if (currentState is HasScore) {
      yield HasScore(
        scoreArabGambar: currentState.scoreArabGambar,
        scoreGambarArab: currentState.scoreGambarArab,
        scoreArabKata: currentState.scoreArabKata,
        scoreKataArab: currentState.scoreKataArab,
        loadScore: true,
      );
    }
    final _email = await _userRepository.getEmail();
    final userScores = await _scoreRepository.getUserScore(_email);

    yield HasScore(
      scoreArabGambar: ListScore(
        mode: GameMode.ArabGambar,
        scoreDocuments: userScores,
      ).score,
      scoreGambarArab: ListScore(
        mode: GameMode.GambarArab,
        scoreDocuments: userScores,
      ).score,
      scoreArabKata: ListScore(
        mode: GameMode.ArabKata,
        scoreDocuments: userScores,
      ).score,
      scoreKataArab: ListScore(
        mode: GameMode.KataArab,
        scoreDocuments: userScores,
      ).score,
      loadScore: false,
    );
  }

  Stream<ScoreState> _mapAddUserScore(
      GameMode quizMode, String quizId, int score, QuizModel metaQuiz) async* {
    final _email = await _userRepository.getEmail();
    try {
      _scoreRepository.addScoreUser(_email, quizMode, quizId, score, metaQuiz);
    } catch (e) {
      print(e);
    }
    // yield ScoreAdded();
  }
}
