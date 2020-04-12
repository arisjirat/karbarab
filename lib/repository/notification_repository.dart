import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/features/auth/model/user_model.dart';
import 'package:karbarab/utils/logger.dart';

const BASE_URL = 'https://fcm.googleapis.com/fcm/send';
const URL = '$BASE_URL';

class NotificationRepository {
  final _client = http.Client();
  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization':
        'key=AAAA72yGgSk:APA91bFbT_oq4xCPNqcEru-OXSZpCzDmNI6wKQ8CRkU5HLoaYjv7Xa1v-12e6kAM2en_dGFXc0_6I2h3cM-2zhF0mU_c4EqPi5RZ7uJ1h-CZc-NyUOiiZIPXuoZFyw_HEnYz_GB94yP6',
  };

  Future<void> sendCardToUser(
    String userRecieverTokenId,
    UserModel userSender,
    String quizId,
    int targetScore,
    GameMode gameMode,
    String scoreId,
  ) async {
    Logger.w('Sending Notification');
    await Future.delayed(const Duration(seconds: 1), () async {
      Logger.e(userRecieverTokenId, s: StackTrace.current);
      try {
        final body = convert.json.encode({
          'to': userRecieverTokenId,
          'priority': 'high',
          // 'collapse_key': 'type_a',
          'notification': {
            'body':
                'Hey kamu dapat quiz ${userSender.username} yang perlu kamu jawab',
            'title': 'Kamu dapat kartu kiriman',
            'image':
                'https://lh3.googleusercontent.com/proxy/SlPQ6zw4v85bQbFWqxkro3KQu2ejoF7giJ0SwoLAzVEO3pauUF-KB6YWlmxwT16iqqunz1SKtoHXMUNfeqz3R1GPp0NNb6I',
          },
          'data': {
            'scoreId': scoreId,
            'userSenderId': userSender.id,
            'quizId': quizId,
            'targetScore': targetScore,
            'gameMode': gameMode,
            'image':
                'https://lh3.googleusercontent.com/proxy/SlPQ6zw4v85bQbFWqxkro3KQu2ejoF7giJ0SwoLAzVEO3pauUF-KB6YWlmxwT16iqqunz1SKtoHXMUNfeqz3R1GPp0NNb6I',
          }
        });
        final http.Response response = await _client.post(
          URL,
          headers: _headers,
          body: body,
        );
        Logger.w('Send Notification Success', e: response.body);
      } catch (e) {
        Logger.w('Send Notification Error', e: e);
        throw Exception();
      }
    });
  }
}
