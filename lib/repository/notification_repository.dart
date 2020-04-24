import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:karbarab/model/score.dart';

import 'package:karbarab/model/user.dart';
import 'package:karbarab/utils/logger.dart';

const BASE_URL = 'https://fcm.googleapis.com/fcm/send';
class NotificationRepository {
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
    await Future.delayed(const Duration(seconds: 1), () async {
      try {
        final body = convert.json.encode({
          'to': score.userTokenSender,
          'priority': 'high',
          'collapse_key': 'type_a',
          'contentAvailable': true,
          'data': {
            'type': 'ANSWER_BATTLE',
            'message': scoreAnswer < score.targetScore ? '${score.metaUser.username} salah menjawab, kamu dapat tambahan score' : 'Namun ${score.metaUser.username} hebat kamu dapat minus score',
            SCORE_ID: score.scoreId,
            USERNAME_SENDER: score.metaUser.username,
            QUIZ_ID: score.quizId,
          }
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
        Logger.w('Answer Notification Success', e: response.body);
      } catch (e) {
        Logger.w('Answer Notification Error', e: e);
        throw Exception();
      }
    });
  }
}
