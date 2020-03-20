part of 'score_bloc.dart';

@immutable
abstract class ScoreEvent extends Equatable {
  const ScoreEvent();

  @override
  List<Object> get props => [];
}

class GetScoreUserByMode extends ScoreEvent {
  final GameMode mode;
  GetScoreUserByMode(this.mode);
}

class GetSummaryUserQuizScore extends ScoreEvent {}

class AddScoreUser extends ScoreEvent {
  final GameMode mode;
  final int score;
  final String quizId;
  final QuizModel metaQuiz;

  AddScoreUser({
    @required this.mode,
    @required this.score,
    @required this.metaQuiz,
    @required this.quizId,
  });
}
