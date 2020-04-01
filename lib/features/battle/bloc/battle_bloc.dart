import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'battle_event.dart';
part 'battle_state.dart';

class BattleBloc extends Bloc<BattleEvent, BattleState> {
  @override
  BattleState get initialState => BattleInitial();

  @override
  Stream<BattleState> mapEventToState(
    BattleEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
