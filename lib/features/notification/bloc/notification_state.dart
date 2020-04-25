part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class HaveNewBattleCard extends NotificationState {
  final bool hasNew;
  HaveNewBattleCard({
    @required this.hasNew,
  });
  @override
  List<Object> get props => [hasNew];
}
