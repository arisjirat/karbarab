import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:karbarab/model/score.dart';
import 'package:karbarab/repository/score_repostitory.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:karbarab/utils/logger.dart';
import 'package:meta/meta.dart';

part 'battle_list_event.dart';
part 'battle_list_state.dart';


class BattleListBloc extends Bloc<BattleListEvent, BattleListState> {
  final UserRepository _userRepository = UserRepository();
  final ScoreRepository _scoreRepository = ScoreRepository();
  @override
  BattleListState get initialState => HasBattleList(
        isComplete: false,
        isLoading: true,
        quizBattle: [],
      );

  @override
  Stream<BattleListState> mapEventToState(
    BattleListEvent event,
  ) async* {
    if (event is GetBattleList) {
      yield* _mapGetBattleList();
    }
  }

  Stream<BattleListState> _mapGetBattleList() async* {
    try {
      final String userId = await _userRepository.getUserId();
      final List<Score> quizBattle = await _scoreRepository.getAllBattleCard(userId);
      yield HasBattleList(
        isComplete: true,
        isLoading: false,
        quizBattle: quizBattle,
      );
    } catch (e) {
      Logger.e('Get score batte list Failed', e: e, s: StackTrace.current);
    }
  }
}
