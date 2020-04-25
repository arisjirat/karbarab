part of 'battle_bloc.dart';

abstract class BattleEvent extends Equatable {
  const BattleEvent();
  @override
  List<Object> get props => [];
}

class ResetSendCardState extends BattleEvent {}

class SendCard extends BattleEvent {
  final User userReciever;
  final Quiz quiz;
  final GameMode gameMode;

  SendCard({
    @required this.userReciever,
    @required this.quiz,
    @required this.gameMode,
  });
}

class GetAllQuizBattleSelf extends BattleEvent {}
