import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:karbarab/features/quiz/model/quiz.dart';
import 'package:karbarab/repository/quiz_repository.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository _quizRepository;

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
    } else if (event is GetQuiz) {
      yield* _mapGetQuizToState(event.image);
    } else if (event is DestroyQuiz) {
      yield* _mapResetQuizToState();
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
}
