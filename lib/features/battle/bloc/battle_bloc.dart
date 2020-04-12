import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/features/auth/model/user_model.dart';
import 'package:karbarab/features/quiz/model/quiz.dart';
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
  BattleState get initialState => BattleInitial();

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
    } else if (event is GetAllQuizBattleSelf) {
      yield* _mapGetAllQuizBattle();
    }
  }

  Stream<BattleState> _mapGetAllQuizBattle() async* {
    final userId = await _userRepository.getUserId();
    final List<DocumentSnapshot> list = await _scoreRepository.getAllBattleCard(userId);
    final List<BattleCardModel> listModel = list.map((e) {
      return BattleCardModel.fromJson(e.data);
    });
    Logger.w('LIST $listModel');
    yield ListQuizBattleCard(listModel);
  }

  Stream<BattleState> _mapSendCardToState(
    UserModel userReciever,
    QuizModel quiz,
    GameMode gameMode,
  ) async* {
    try {
      yield SendCardState(false, false, true);
      final BattleCardModel payload = BattleCardModel(
        userId: userReciever.id,
        userIdSender: await _userRepository.getUserId(),
        quizMode: gameMode,
        quizId: quiz.id,
        targetScore: 100,
        score: 0,
        metaQuiz: quiz,
        metaUser: userReciever,
      );
      final scoreId =  await _scoreRepository.addBattleCard(payload);
      await _notificationRepository.sendCardToUser(
        userReciever.tokenFCM,
        await _userRepository.getUserMeta(),
        quiz.id,
        payload.targetScore,
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
