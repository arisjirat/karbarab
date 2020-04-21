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
  final double score;
  final String userId;
  final User metaUser;
  final List<Score> scoreHistory;
  final String userIdSender;

  ScoreGlobalModel({
    @required this.userId,
    @required this.score,
    @required this.metaUser,
    @required this.scoreHistory,
    this.userIdSender,
  });
}
