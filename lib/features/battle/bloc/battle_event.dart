part of 'battle_bloc.dart';

abstract class BattleEvent extends Equatable {
  const BattleEvent();
  @override
  List<Object> get props => [];
}

class SendCard extends BattleEvent {
  final UserModel userReciever;
  final QuizModel quiz;
  final GameMode gameMode;

  SendCard({
    @required this.userReciever,
    @required this.quiz,
    @required this.gameMode,
  });
}
