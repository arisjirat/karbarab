import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/features/notification/model/notification.model.dart';
import 'package:karbarab/model/quiz.dart';
import 'package:karbarab/model/score.dart';
import 'package:karbarab/model/user.dart';
import 'package:karbarab/repository/quiz_repository.dart';
import 'package:karbarab/repository/score_repostitory.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:karbarab/utils/logger.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final QuizRepository _quizRepository = QuizRepository();
  final UserRepository _userRepository = UserRepository();
  final ScoreRepository _scoreRepository = ScoreRepository();

  @override
  NotificationState get initialState => NotificationInitial();

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    Logger.w('event $event');
    if (event is OnPushNotification) {
      Logger.w('Notifi');
      yield* _pushNotifToState(event.message);
    }
  }

  Stream<NotificationState> _pushNotifToState(
    DataModel message,
  ) async* {
    try {
      Logger.w('Notif to State ');
      final String quizId = message.quizId;
      final String scoreId = message.scoreId;
      // final GameMode gameMode = stringToGameMode(message.gameMode);
      final String targetScore = message.targetScore;
      final userSenderUsername = message.userSenderUsername;
      final Quiz quiz = _quizRepository.getSingleQuiz(quizId);
      final DocumentSnapshot userSnapshot =
          await _userRepository.getUserFromUsername(userSenderUsername);
      final getScore = (await _scoreRepository.getSingleScore(scoreId)).data;
      final BattleCardModel battleCardModel = BattleCardModel.fromJson(getScore);
      // final UserModel userSender = UserModel(
      //   id: userSnapshot.data['id'],
      //   tokenFCM: userSnapshot.data['tokenFCM'],
      //   isGoogleAuth: userSnapshot.data['isGoogleAuth'],
      //   username: userSnapshot.data['username'],
      // );
      // yield HaveNewBattleCard(
      //     quiz: quiz,
      //     userSender: userSender,
      //     targetScore: int.parse(targetScore),
      //     gameMode: GameMode.ArabGambar,
      //     battleCard: battleCardModel);
    } catch (e) {
      Logger.e('Error disini', e: e, s: StackTrace.current);
    }
  }
}
