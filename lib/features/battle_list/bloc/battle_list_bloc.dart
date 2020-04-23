import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:karbarab/model/score.dart';
import 'package:karbarab/model/user.dart';
import 'package:karbarab/repository/score_repostitory.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:karbarab/utils/logger.dart';
import 'package:meta/meta.dart';

part 'battle_list_event.dart';
part 'battle_list_state.dart';


class BattleListBloc extends Bloc<BattleListEvent, BattleListState> {
  final UserRepository _userRepository;
  final ScoreRepository _scoreRepository = ScoreRepository();

  BattleListBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

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
    } else if (event is GetAllBattleAvtiveCount) {
      yield* _mapBattleActiveCardToState();
    }
  }

  Stream<BattleListState> _mapBattleActiveCardToState() async* {
    yield HasBattleList(isComplete: false, isLoading: true, quizBattle: []);
    final userId = await _userRepository.getUserId();
    final list = await _scoreRepository.getAllBattleCardUnSolved(userId);
    yield HasBattleList(isComplete: true, isLoading: false, quizBattle: list);
  }

  Stream<BattleListState> _mapGetBattleList() async* {
    try {
      yield HasBattleList(isComplete: false, isLoading: true, quizBattle: []);
      final User user = await _userRepository.getUserMeta();
      final List<Score> quizBattle = await _scoreRepository.getAllBattleCard(user.id);
      yield HasBattleList(
        isComplete: true,
        isLoading: false,
        quizBattle: quizBattle,
        user: user,
      );
    } catch (e) {
      Logger.e('Get score batte list Failed', e: e, s: StackTrace.current);
    }
  }
}
