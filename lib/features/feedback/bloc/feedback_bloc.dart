import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:karbarab/model/quiz.dart';
import 'package:karbarab/model/score.dart';

import 'package:karbarab/model/user.dart';
import 'package:karbarab/repository/quiz_repository.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final UserRepository _userRepository = UserRepository();
  final CollectionReference feedbackCollection =
      Firestore.instance.collection('feedback');

  @override
  FeedbackState get initialState => FeedbackState.empty();

  @override
  Stream<FeedbackState> mapEventToState(
    FeedbackEvent event,
  ) async* {
    if (event is ResetFeedbackQuiz) {
      yield FeedbackState.empty();
    }
    if (event is AddFeedbackQuiz) {
      yield* _mapAddFeedbackQuiz(
        event.quizId,
        event.quizMode,
        event.metaQuiz,
        event.shouldBe,
        event.notes,
      );
    }
  }

  Stream<FeedbackState> _mapAddFeedbackQuiz(
    String quizId,
    GameMode gameMode,
    Quiz metaQuiz,
    String shouldBe,
    String notes,
  ) async* {
    try {
      yield FeedbackState.loading();
      final User user = await _userRepository.getUserMeta();
      await feedbackCollection.document().setData({
        'user': UserRepository.toMap(user),
        'metaQuiz': QuizRepository.toMap(metaQuiz),
        'quizId': quizId,
        'adsMode': GameModeHelper.stringOf(gameMode),
        'shouldBe': shouldBe,
        'notes': notes,
        'createdAt': FieldValue.serverTimestamp()
      });
      yield FeedbackState.success();
    } catch (e) {
      yield FeedbackState.failure();
    }
  }
}
