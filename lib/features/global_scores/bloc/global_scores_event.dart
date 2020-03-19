part of 'global_scores_bloc.dart';

abstract class GlobalScoresEvent extends Equatable {
  const GlobalScoresEvent();
  @override
  List<Object> get props => [];
}

class GetGlobalScores extends GlobalScoresEvent {}