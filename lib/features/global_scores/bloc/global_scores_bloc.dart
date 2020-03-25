import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/features/auth/model/user_model.dart';
import 'package:karbarab/repository/score_repostitory.dart';
import 'package:meta/meta.dart';
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
    yield GlobalHasScores(scores);
  }
}
