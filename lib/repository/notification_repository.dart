import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:karbarab/features/auth/model/user_model.dart';
import 'package:karbarab/utils/logger.dart';

// const DATA='{'notification':{'body':'Coba body gue","title":"Not Notification"},"priority":"high","data":{"name":"Joko Susilo Bambang","age":10},"to":"ddSozQSlZF4:APA91bGhbJjKRoYg1eq0kejOZj06zsuW1x-qu4kgHmp4V1OUJZSGzq-7d13DlQRE2mgGrXtwDemgXkiuEsj7Py4zF0FaZSprSNXp6niqw_6WHQV_cB1AotKF3RREv0ggACSwLRZ5QLlU"}';

// curl https://fcm.googleapis.com/fcm/send -H "Content-Type:application/json" -X POST -d "$DATA" -H "Authorization: key=AAAA72yGgSk:APA91bFbT_oq4xCPNqcEru-OXSZpCzDmNI6wKQ8CRkU5HLoaYjv7Xa1v-12e6kAM2en_dGFXc0_6I2h3cM-2zhF0mU_c4EqPi5RZ7uJ1h-CZc-NyUOiiZIPXuoZFyw_HEnYz_GB94yP6"

// const KEY = 'AIzaSyDCHHs-nQ2pNZw2j9Lgx2x1Y0zDOUqfmm4';
// Authorization: key=AAAA72yGgSk:APA91bFbT_oq4xCPNqcEru-OXSZpCzDmNI6wKQ8CRkU5HLoaYjv7Xa1v-12e6kAM2en_dGFXc0_6I2h3cM-2zhF0mU_c4EqPi5RZ7uJ1h-CZc-NyUOiiZIPXuoZFyw_HEnYz_GB94yP6
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
  ) async {
    Logger.w('Sending Notification');
    await Future.delayed(Duration(seconds: 2), () async {
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
            'userSenderId': userSender.id,
            'quizId': quizId,
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

// {
//   "to": "erIS-zLZ1RM:APA91bGtbZzkxgcmkt1QIDUP6x8VtU2hFj2pEslzpEnLp4nzgOVBWlFqQz-cFtV5irXio1LTDnd5jTVYoz3aneEK1DSWrsHly4ICspnsCytowdp6ZbP1xguiwSNChPFv9n4dTfINDJLS",
//   "priority": "high",
//   "collapse_key": "type_a",
//   "notification": {
//     "body":
//         "Hey kamu dapat quiz Nganu yang perlu kamu jawab",
//     "title": "Kamu dapat kartu kiriman",
//     "image":
//         "https://lh3.googleusercontent.com/proxy/SlPQ6zw4v85bQbFWqxkro3KQu2ejoF7giJ0SwoLAzVEO3pauUF-KB6YWlmxwT16iqqunz1SKtoHXMUNfeqz3R1GPp0NNb6I"
//   },
//   "data": {
//     "userSenderId": 232,
//     "quizId": 2,
//     "image":
//         "https://lh3.googleusercontent.com/proxy/SlPQ6zw4v85bQbFWqxkro3KQu2ejoF7giJ0SwoLAzVEO3pauUF-KB6YWlmxwT16iqqunz1SKtoHXMUNfeqz3R1GPp0NNb6I"
//   }
// }

// DATA='{"notification":{"body":"Coba body gue","title":"Not Notification"},"priority":"high","data":{"name":"Joko Susilo Bambang","age":10},"to":"erIS-zLZ1RM:APA91bGtbZzkxgcmkt1QIDUP6x8VtU2hFj2pEslzpEnLp4nzgOVBWlFqQz-cFtV5irXio1LTDnd5jTVYoz3aneEK1DSWrsHly4ICspnsCytowdp6ZbP1xguiwSNChPFv9n4dTfINDJLS"}'