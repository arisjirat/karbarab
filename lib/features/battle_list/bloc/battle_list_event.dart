part of 'battle_list_bloc.dart';

abstract class BattleListEvent extends Equatable {
  const BattleListEvent();
  @override
  List<Object> get props => [];
}

class GetBattleList extends BattleListEvent {}

