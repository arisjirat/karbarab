part of 'score_bloc.dart';

@immutable
abstract class ScoreEvent extends Equatable {
  const ScoreEvent();

  @override
  List<Object> get props => [];
}

class GetScoreUserByMode extends ScoreEvent {}

class GetSummaryUserQuizScore extends ScoreEvent {}

class AddScoreUser extends ScoreEvent {
  final GameMode mode;
  final double score;
  final String quizId;
  final Quiz metaQuiz;

  AddScoreUser({
    @required this.mode,
    @required this.score,
    @required this.metaQuiz,
    @required this.quizId,
  });
}

class DirtyBattle extends ScoreEvent {
  final Score score;

  DirtyBattle({
    @required this.score,
  });
}

class SolvedBattle extends ScoreEvent {
  final Score battleQuiz;
  final double score;

  SolvedBattle({
    @required this.score,
    @required this.battleQuiz,
  });
}
