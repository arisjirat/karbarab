part of 'battle_bloc.dart';

abstract class BattleState extends Equatable {
  const BattleState();
}

class BattleInitial extends BattleState {
  @override
  List<Object> get props => [];
}
