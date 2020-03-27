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
  final UserModel metaUser;
  final List<ScoreItem> scoreHistory;

  ScoreGlobalModel({
    @required this.userMail,
    @required this.score,
    @required this.metaUser,
    @required this.scoreHistory,
  });
}

class ScoreItem {
  final GameMode mode;
  final int score;
  final String bahasa;
  final DateTime date;
  ScoreItem({
    @required this.mode,
    @required this.score,
    @required this.bahasa,
    @required this.date,
  });
}
