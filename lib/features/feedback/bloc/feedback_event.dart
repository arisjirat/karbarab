part of 'feedback_bloc.dart';

@immutable
abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();
  @override
  List<Object> get props => [];
}

class ResetFeedbackQuiz extends FeedbackEvent {}

class AddFeedbackQuiz extends FeedbackEvent {
  final String quizId;
  final String shouldBe;
  final String notes;
  final GameMode quizMode;
  final QuizModel metaQuiz;
  AddFeedbackQuiz({
    @required this.quizId,
    @required this.shouldBe,
    this.notes,
    @required this.quizMode,
    @required this.metaQuiz,
  });
}
