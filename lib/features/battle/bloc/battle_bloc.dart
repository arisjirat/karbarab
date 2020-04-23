import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:karbarab/core/config/score_value.dart';
import 'package:karbarab/model/quiz.dart';
import 'package:karbarab/model/score.dart';

import 'package:karbarab/model/user.dart';
import 'package:karbarab/repository/notification_repository.dart';
import 'package:karbarab/repository/score_repostitory.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:karbarab/utils/logger.dart';
import 'package:meta/meta.dart';

part 'battle_event.dart';
part 'battle_state.dart';

class BattleBloc extends Bloc<BattleEvent, BattleState> {
  final UserRepository _userRepository = UserRepository();
  final ScoreRepository _scoreRepository = ScoreRepository();
  final NotificationRepository _notificationRepository = NotificationRepository();


  @override
  BattleState get initialState => SendCardState(false, false, false);

  @override
  Stream<BattleState> mapEventToState(
    BattleEvent event,
  ) async* {
    if (event is SendCard) {
      yield* _mapSendCardToState(
        event.userReciever,
        event.quiz,
        event.gameMode,
      );
    } else if (event is ResetSendCardState) {
      yield SendCardState(false, false, false);
    }
  }

  Stream<BattleState> _mapSendCardToState(
    User userReciever,
    Quiz quiz,
    GameMode gameMode,
  ) async* {
    try {
      final userSender = await _userRepository.getUserMeta();
      yield SendCardState(false, false, true);
      final scoreId =  await _scoreRepository.addBattleCard(userReciever, quiz, gameMode, userSender);
      await _userRepository.decreaseSendCardLimit();
      await _notificationRepository.sendCardToUser(
        userReciever.tokenFCM,
        await _userRepository.getUserMeta(),
        quiz.id,
        SCORE_TARGET_BATTLE,
        gameMode,
        scoreId,
      );
      yield SendCardState(true, false, false);
    } catch (e) {
      yield SendCardState(false, true, false);
      Logger.e('[ERROR SEND CARD EVENT]', s: StackTrace.current, e: e);
    }

  }
}
