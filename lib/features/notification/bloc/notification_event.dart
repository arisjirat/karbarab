part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override
  List<Object> get props => [];
}

class OnPushNotification extends NotificationEvent {
  final String payload;
  OnPushNotification(this.payload);
}

class ResetNotification extends NotificationEvent {}