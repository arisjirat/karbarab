import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  @override
  QuizState get initialState => QuizState.empty();

  @override
  Stream<QuizState> mapEventToState(
    QuizEvent event,
  ) async* {
    _mapLoginWithGooglePressedToState();
  }
  Stream<QuizState> _mapLoginWithGooglePressedToState() async* {
    try {
      yield QuizState.correct();
    } catch (_) {
      yield QuizState.inCorrect();
    }
  }
}
