import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:karbarab/repository/speech_repository.dart';
import 'package:karbarab/utils/logger.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'voices_event.dart';
part 'voices_state.dart';

const VOICES_PREFERENCES = 'voices';

class VoicesBloc extends Bloc<VoicesEvent, VoicesState> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SpeechRepository _speechRepository = SpeechRepository();
  @override
  VoicesState get initialState => VoicesState.empty();

  @override
  Stream<VoicesState> mapEventToState(
    VoicesEvent event,
  ) async* {
    if (event is GetSpeech) {
      yield* _mapGetSpeech(event.quizId, event.arab);
    } else if (event is StopSpeech) {
      yield VoicesState.empty();
    }
  }

  Stream<VoicesState> _mapGetSpeech(String quizId, String arab) async* {
    yield VoicesState.loading();
    final SharedPreferences prefs = await _prefs;
    final List<String> _voices = prefs.getStringList(VOICES_PREFERENCES);
    if (_voices == null) {
      final String speech = await _speechRepository.textToSpeech(quizId, arab);
      await prefs.setStringList(VOICES_PREFERENCES, [speech]);
      yield VoicesState.success(quizId, speech);
    } else {
      final RegExp regExp = RegExp('/($quizId.mp3)');
      try {
        final String voice = _voices.firstWhere((v) => regExp.hasMatch(v));
        Logger.e('VOICE FOUND', e: voice);
        yield VoicesState.success(quizId, voice);
      } catch (e) {
        Logger.e('VOICE NOT FOUND', e: e);
        final String speech = await _speechRepository.textToSpeech(quizId, arab);
        await prefs.setStringList(VOICES_PREFERENCES, [speech]);
        yield VoicesState.success(quizId, speech);
      }
    }
  }
}
