part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override
  List<Object> get props => [];
}

class OnPushNotification extends NotificationEvent {
  final DataModel message;
  OnPushNotification(this.message);
}

class OnAppPushNotification extends NotificationEvent {
  final DataModel message;
  OnAppPushNotification(this.message);
}