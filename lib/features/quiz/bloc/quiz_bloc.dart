import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:karbarab/features/score/bloc/score_bloc.dart';
import 'package:karbarab/model/quiz.dart';
import 'package:karbarab/model/score.dart';
import 'package:karbarab/repository/quiz_repository.dart';
import 'package:karbarab/repository/score_repostitory.dart';
import 'package:karbarab/repository/user_repository.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository _quizRepository;
  final ScoreRepository _scoreRepository = ScoreRepository();
  final UserRepository _userRepository = UserRepository();

  QuizBloc({@required QuizRepository quizRepository})
      : assert(quizRepository != null),
        _quizRepository = quizRepository;

  @override
  QuizState get initialState => EmptyQuiz();

  @override
  Stream<QuizState> mapEventToState(
    QuizEvent event,
  ) async* {
    if (event is Initialize) {
      yield* _mapAppStartedToState();
    } else if (event is GetBattleQuiz) {
      yield* _mapGetBattleQuizToState(event.battleQuiz);
    } else if (event is GetQuiz) {
      yield* _mapGetQuizToState(event.image);
    } else if (event is DestroyQuiz) {
      yield* _mapResetQuizToState();
    } else if (event is GetAllGoodQuiz) {
      yield* _mapGetAllGoodQuizToState();
    } else if (event is GetAllQuiz) {
      final quiz = _quizRepository.allQuiz();
      yield AllQuiz(quiz);
    }
  }

  Stream<QuizState> _mapAppStartedToState() async* {
    yield EmptyQuiz();
  }
  Stream<QuizState> _mapResetQuizToState() async* {
    yield EmptyQuiz();
  }

  Stream<QuizState> _mapGetQuizToState(bool image) async* {
    final quiz = _quizRepository.getQuiz(image);
    yield HasQuiz(list: quiz.list, correct: quiz.correct);
  }

  Stream<QuizState> _mapGetBattleQuizToState(Score battleQuiz) async* {
    final quiz = _quizRepository.getBattleQuiz(battleQuiz);
    yield HasQuiz(list: quiz.list, correct: battleQuiz.metaQuiz);
  }

  Stream<QuizState> _mapGetAllGoodQuizToState() async* {
    yield AllGoodQuiz(list: [], isLoading: true, isSuccess: false);
    final _id = await _userRepository.getUserId();
    final List<List<ScoreQuiz>> _userScores =
        await _scoreRepository.getUserScoreGoodOrBadQuiz(_id);
    final List<ScoreQuiz> scores = _userScores[1];
    final List<Quiz> allQuizGood = scores.fold([], (a, s) {
      a.add(_quizRepository.getSingleQuiz(s.quizId));
      return a;
    });
    
    yield AllGoodQuiz(list:allQuizGood, isLoading: false, isSuccess: true);
  }
}
