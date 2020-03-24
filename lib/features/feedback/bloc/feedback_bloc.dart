import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/core/helper/log_printer.dart';
import 'package:karbarab/core/helper/utils.dart';
import 'package:karbarab/features/auth/model/user_model.dart';
import 'package:karbarab/features/quiz/model/quiz.dart';
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
    QuizModel metaQuiz,
    String shouldBe,
    String notes,
  ) async* {
    try {
      yield FeedbackState.loading();
      final UserModel user = await _userRepository.getUserMeta();
      await feedbackCollection.document().setData({
        'user': user.toJson(),
        'metaQuiz': metaQuiz.toJson(),
        'quizId': quizId,
        'adsMode': gameModeToString(gameMode),
        'shouldBe': shouldBe,
        'notes': notes,
        'createdAt': FieldValue.serverTimestamp()
      });
      yield FeedbackState.success();
    } catch (e) {
      getLogger('ErrorFeedback').e(e);
      yield FeedbackState.failure();
    }
  }
}
