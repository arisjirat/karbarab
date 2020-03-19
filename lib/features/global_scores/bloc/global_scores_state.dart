part of 'global_scores_bloc.dart';

abstract class GlobalScoresState extends Equatable {
  const GlobalScoresState();
}

class GlobalScoresInitial extends GlobalScoresState {
  @override
  List<Object> get props => [];
}

class GlobalHasScores extends GlobalScoresState {
  final List<ScoreGlobalModel> all;
  GlobalHasScores(this.all);

  @override
  List<Object> get props => [all];
}

class ScoreGlobalModel {
  final int score;
  final String userMail;

  ScoreGlobalModel(this.userMail, this.score);
}