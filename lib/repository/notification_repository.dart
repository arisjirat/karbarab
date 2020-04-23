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
        'key=AAAA3XBgq14:APA91bHjH4lhwz1ZDqq8IFVQ0zJIl8qAg2AXxSp8Xm6PsoulMvamuyGsBsb_jie6gsuywlFAeEGHcfgRM27ruDX1ieptBQ4GwzpHOHIMq2X-xU8vbEHlj7DheDM4Sj_Es1xn1BcqVUo8',
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
            'message': scoreAnswer < score.targetScore ? '${score.metaUser.username} salah menjawab, kamu dapat tambahan score' : 'Namun ${score.metaUser.username} hebat kamu dapat minus score',
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
