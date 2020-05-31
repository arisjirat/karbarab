library notification_queue;

import 'package:built_value/built_value.dart';

part 'notification_queue.g.dart';
const ID_NOTIFICATION_QUEUE = 'id';
const TIME_MICRO_NOTIFICATION_QUEUE = 'time_micro';
const SCORE_ID_NOTIFICATION_QUEUE = 'score_id';
const USER_ID_SENDER_NOTIFICATION_QUEUE = 'user_id_sender';
const QUIZ_ID_NOTIFICATION_QUEUE = 'quiz_id';
const TARGET_SCORE_NOTIFICATION_QUEUE = 'target_score';
const USERNAME_SENDER_NOTIFICATION_QUEUE = 'username_sender';
const TITLE_NOTIFICATION_QUEUE = 'title_notification';
const MESSASGE_NOTIFICATION_QUEUE = 'message_notification';
const ACTION_NOTIFICATION_TYPE_QUEUE = 'action_notification_type_queue';

abstract class NotificationQueue implements Built<NotificationQueue, NotificationQueueBuilder> {
  String get id;
  int get timeMicro;
  String get scoreId;
  String get userIdSender;
  String get quizId;
  double get targetScore;
  String get usernameSender;
  String get title;
  String get message;
  ActionTypeNotification get actionNotificationType;

  factory NotificationQueue([updates(NotificationQueueBuilder b)]) = _$NotificationQueue;
  NotificationQueue._();

}

enum ActionTypeNotification {
  SendBattleCard,
  AnswerBattleCard,
}

class ActionTypeNotificationHelper {
  static String stringOf(ActionTypeNotification gameMode) {
    switch (gameMode) {
      case ActionTypeNotification.SendBattleCard:
        return 'SendBattleCard';
      case ActionTypeNotification.AnswerBattleCard:
        return 'AnswerBattleCard';
      default:
        return 'SendBattleCard';
    }
  }

  static ActionTypeNotification valueOf(String string) {
    switch (string) {
      case 'SendBattleCard':
        return ActionTypeNotification.SendBattleCard;
      case 'AnswerBattleCard':
        return ActionTypeNotification.AnswerBattleCard;
      default:
        return ActionTypeNotification.SendBattleCard;
    }
  }
}
