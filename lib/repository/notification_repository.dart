import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:karbarab/model/notification_queue.dart';
import 'package:karbarab/model/score.dart';

import 'package:karbarab/model/user.dart';
import 'package:karbarab/utils/logger.dart';
import 'package:uuid/uuid.dart';

const BASE_URL = 'https://fcm.googleapis.com/fcm/send';

class NotificationRepository {
  static NotificationQueue fromJson(Map<String, dynamic> json) {
    return NotificationQueue(
      (n) => n
        ..scoreId = json[SCORE_ID_NOTIFICATION_QUEUE]
        ..actionNotificationType = ActionTypeNotificationHelper.valueOf(json[ACTION_NOTIFICATION_TYPE_QUEUE])
        ..timeMicro = json[TIME_MICRO_NOTIFICATION_QUEUE] is int ? json[TIME_MICRO_NOTIFICATION_QUEUE]  : int.parse(json[TIME_MICRO_NOTIFICATION_QUEUE])
        ..id = json[ID_NOTIFICATION_QUEUE]
        ..userIdSender =  json[USER_ID_SENDER_NOTIFICATION_QUEUE]
        ..quizId = json[QUIZ_ID_NOTIFICATION_QUEUE]
        ..targetScore = json[TARGET_SCORE_NOTIFICATION_QUEUE] is double ? json[TARGET_SCORE_NOTIFICATION_QUEUE] : double.parse(json[TARGET_SCORE_NOTIFICATION_QUEUE])
        ..usernameSender = json[USERNAME_SENDER_NOTIFICATION_QUEUE]
        ..title = json[TITLE_NOTIFICATION_QUEUE]
        ..message = json[MESSASGE_NOTIFICATION_QUEUE]
        ,
    );
  }

  static Map<String, dynamic> toMap(NotificationQueue notificationQueue) {
    return {
      ID_NOTIFICATION_QUEUE: notificationQueue.id,
      TIME_MICRO_NOTIFICATION_QUEUE: notificationQueue.timeMicro,
      SCORE_ID_NOTIFICATION_QUEUE: notificationQueue.scoreId,
      ACTION_NOTIFICATION_TYPE_QUEUE: ActionTypeNotificationHelper.stringOf(notificationQueue.actionNotificationType),
      USER_ID_SENDER_NOTIFICATION_QUEUE: notificationQueue.userIdSender,
      QUIZ_ID_NOTIFICATION_QUEUE: notificationQueue.quizId,
      TARGET_SCORE_NOTIFICATION_QUEUE: notificationQueue.targetScore,
      USERNAME_SENDER_NOTIFICATION_QUEUE: notificationQueue.usernameSender,
      TITLE_NOTIFICATION_QUEUE: notificationQueue.title,
      MESSASGE_NOTIFICATION_QUEUE: notificationQueue.message,
    };
  }

  final String key = DotEnv().env['FIREBASE'];
  final _client = http.Client();
  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<void> sendCardToUser(
    String userRecieverTokenId,
    User userSender,
    String quizId,
    double targetScore,
    GameMode gameMode,
    String scoreId,
  ) async {
    final NotificationQueue data = NotificationQueue(
      (n) => n
      ..scoreId = scoreId
      ..actionNotificationType = ActionTypeNotification.SendBattleCard
      ..timeMicro = DateTime.now().microsecondsSinceEpoch
      ..id = Uuid().v4()
      ..userIdSender = userSender.id
      ..quizId = quizId
      ..targetScore = targetScore
      ..usernameSender = userSender.username
      ..title = 'Hai kamu dapat kartu!'
      ..message = 'Coba jawab kartu dari ${userSender.username}'
    );
    await Future.delayed(const Duration(seconds: 1), () async {
      try {
        final body = convert.json.encode({
          'to': userRecieverTokenId,
          'priority': 'high',
          'collapse_key': 'type_a',
          'contentAvailable': true,
          'data': toMap(data),
        });
        _headers['Authorization'] = 'key=$key';
        final http.Response response = await _client.post(
          BASE_URL,
          headers: _headers,
          body: body,
        );
        if (response.statusCode != 200) {
          return throw Error();
        }
        Logger.w('Send Notification Success', e: response.body);
        return;
      } catch (e) {
        Logger.w('Send Notification Error', e: e);
        throw Exception();
      }
    });
  }

  Future<void> answerNotification(
    Score score,
    double scoreAnswer,
  ) async {
    final NotificationQueue data = NotificationQueue(
      (n) => n
      ..scoreId = score.scoreId
      ..actionNotificationType = ActionTypeNotification.AnswerBattleCard
      ..timeMicro = DateTime.now().microsecondsSinceEpoch
      ..id = Uuid().v4()
      ..userIdSender = score.userIdSender
      ..quizId = score.quizId
      ..targetScore = score.targetScore
      ..usernameSender = score.usernameSender
      ..title = '${score.metaUser.username} salah menjawab, kamu dapat tambahan score'
      ..message = 'Namun ${score.metaUser.username} hebat kamu dapat minus score'
    );
    await Future.delayed(const Duration(seconds: 1), () async {
      try {
        final body = convert.json.encode({
          'to': score.userTokenSender,
          'priority': 'high',
          'collapse_key': 'type_a',
          'contentAvailable': true,
          'data': toMap(data),
        });
        _headers['Authorization'] = 'key=$key';
        final http.Response response = await _client.post(
          BASE_URL,
          headers: _headers,
          body: body,
        );
        if (response.statusCode != 200) {
          return throw Error();
        }
        Logger.w('${ActionTypeNotification.AnswerBattleCard} Success', e: response.body);
      } catch (e) {
        Logger.w('${ActionTypeNotification.AnswerBattleCard} Error', e: e);
        throw Exception();
      }
    });
  }
}
