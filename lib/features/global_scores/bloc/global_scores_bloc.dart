import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:karbarab/repository/score_repostitory.dart';

part 'global_scores_event.dart';
part 'global_scores_state.dart';

class GlobalScoresBloc extends Bloc<GlobalScoresEvent, GlobalScoresState> {
  @override
  GlobalScoresState get initialState => GlobalScoresInitial();

  final ScoreRepository _scoreRepository = ScoreRepository();

  @override
  Stream<GlobalScoresState> mapEventToState(
    GlobalScoresEvent event,
  ) async* {
    if (event is GetGlobalScores) {
      yield* _mapGetGlobalScores();
    }
  }

  Stream<GlobalScoresState> _mapGetGlobalScores() async* {
    final scores = await _scoreRepository.getAllScore();
    print(scores);
    yield GlobalHasScores(scores);
  }
}