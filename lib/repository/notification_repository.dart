import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:karbarab/model/score.dart';

import 'package:karbarab/model/user.dart';
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
    User userSender,
    String quizId,
    double targetScore,
    GameMode gameMode,
    String scoreId,
  ) async {
    await Future.delayed(const Duration(seconds: 1), () async {
      try {
        final body = convert.json.encode({
          'to': userRecieverTokenId,
          'priority': 'high',
          'collapse_key': 'type_a',
          'contentAvailable': true,
          'data': {
            'type': 'BATTLE',
            SCORE_ID: scoreId,
            USER_ID_SENDER: userSender.id,
            USERNAME_SENDER: userSender.username,
            QUIZ_ID: quizId,
            TARGET_SCORE: targetScore,
            QUIZ_MODE: GameModeHelper.stringOf(gameMode),
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

  Future<void> answerNotification(
    Score score,
    double scoreAnswer,
  ) async {
    await Future.delayed(const Duration(seconds: 1), () async {
      try {
        final body = convert.json.encode({
          'to': score.userTokenSender,
          'priority': 'high',
          'collapse_key': 'type_a',
          'contentAvailable': true,
          'data': {
            'type': 'ANSWER_BATTLE',
            'message': scoreAnswer == score.targetScore ? '${score.metaUser.username} salah menjawab, kamu dapat tambahan score' : 'Namun ${score.metaUser.username} hebat kamu dapat minus score',
            SCORE_ID: score.scoreId,
            USERNAME_SENDER: score.metaUser.username,
            QUIZ_ID: score.quizId,
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
