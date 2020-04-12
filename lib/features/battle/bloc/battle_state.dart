part of 'battle_bloc.dart';

abstract class BattleState extends Equatable {
  const BattleState();
}

class BattleInitial extends BattleState {
  @override
  List<Object> get props => [];
}

class SendCardState extends BattleState {
  final bool isSuccess;
  final bool isFailure;
  final bool isLoading;
  SendCardState(this.isSuccess, this.isFailure, this.isLoading);
  @override
  List<Object> get props => [
    isSuccess,
    isFailure,
    isLoading,
  ];
}

class ListQuizBattleCard extends BattleState {
  final List<BattleCardModel> listBattle;
  ListQuizBattleCard(this.listBattle);

  @override
  List<Object> get props => [
    listBattle,
  ];
}