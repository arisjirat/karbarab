import 'dart:convert' as convert;
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:karbarab/utils/logger.dart';
import 'package:path_provider/path_provider.dart';

const BASE_URL = 'https://texttospeech.googleapis.com';


class SpeechRepository {
  final client = http.Client();
  static final url = '$BASE_URL/v1/text:synthesize?key=';
  Future<String> textToSpeech(String id, String arab) async {
    print(DotEnv().env);
    final String apiKey = DotEnv().env['GCP_API_KEY'];
    final Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final body = convert.json.encode({
      'input': {
        'text': arab,
      },
      'voice': {
        'languageCode': 'ar-AR',
        'ssmlGender': 'FEMALE',
      },
      'audioConfig': {
        'audioEncoding': 'MP3',
      },
    });
    try {
      final http.Response response = await client.post(
        url + apiKey,
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        final audioContent = jsonResponse['audioContent'];
        final Uint8List bytes = convert.base64.decode(audioContent);
        final String dir = (await getApplicationDocumentsDirectory()).path;
        final String fullPath = '$dir/$id.mp3';
        final File file = File(fullPath);
        await file.writeAsBytes(bytes);
        return file.path;
      } else {
        throw VoiceException('Should contact developer', response);
      }
    } on VoiceException {
      return throw Error();
    } catch (e) {
      Logger.w('Get Voice', e: e, s: StackTrace.current);
      return throw Error();
    }
  }
}

class VoiceException implements Exception {
  String cause;
  http.Response response;
  VoiceException(this.cause, this.response);
}
