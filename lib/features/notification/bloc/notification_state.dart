part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class HaveNewBattleCard extends NotificationState {
  final QuizModel quiz;
  final User userSender;
  final int targetScore;
  final GameMode gameMode;
  final BattleCardModel battleCard;
  HaveNewBattleCard({
    @required this.quiz,
    @required this.userSender,
    @required this.targetScore,
    @required this.gameMode,
    @required this.battleCard,
  });
  @override
  List<Object> get props => [quiz, userSender, targetScore, gameMode];
}
