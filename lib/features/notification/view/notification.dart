import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karbarab/core/config/colors.dart';
import 'package:karbarab/core/ui/popup.dart';

import 'package:karbarab/features/battle/view/answer_card.dart';
import 'package:karbarab/features/notification/bloc/notification_bloc.dart';
import 'package:karbarab/features/notification/model/notification.model.dart';
import 'package:karbarab/features/quiz/model/quiz.dart';
import 'package:karbarab/model/user.dart';
import 'package:karbarab/repository/quiz_repository.dart';
import 'package:karbarab/repository/score_repostitory.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:karbarab/utils/logger.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key key}) : super(key: key);

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final UserRepository userRepository = UserRepository();
  final QuizRepository quizRepository = QuizRepository();

  void _showModal(
    QuizModel quiz,
    User sender,
    int targetScore,
    BattleCardModel battleCardModel,
  ) {
    popup(context, confirm: () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return AnswerQuestionCardBattle(
          scoreId: battleCardModel.scoreId,
          quiz: quiz,
          targetScore: targetScore,
          // userRepository: userRepository,
        );
      }), ModalRoute.withName('/answer'));
    }, cancel: () {
      Navigator.of(context).pop();
    },
        cancelAble: true,
        cancelLabel: 'Nanti saja',
        text: 'Kartu kiriman',
        paragraph: 'dapat dari ${sender.username}');
  }

  @override
  void initState() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        Logger.w('[onMessage] $message');
        try {
          final DataModel messageModeles =
              DataModel.fromJson(Map<String, dynamic>.from(message['data']));
          BlocProvider.of<NotificationBloc>(context)
              .add(OnPushNotification(messageModeles));
        } catch (e) {
          Logger.e('[ER]', s: StackTrace.current, e: e);
        }
        // _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        Logger.w('[onLaunch] $message');
        final DataModel messageModeles =
            DataModel.fromJson(Map<String, dynamic>.from(message['data']));
        BlocProvider.of<NotificationBloc>(context)
            .add(OnPushNotification(messageModeles));
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        Logger.w('[Resume] $message');
        final DataModel messageModeles =
            DataModel.fromJson(Map<String, dynamic>.from(message['data']));
        BlocProvider.of<NotificationBloc>(context)
            .add(OnPushNotification(messageModeles));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (c, state) {
        Logger.w('on state $state');
        if (state is HaveNewBattleCard) {
          _showModal(state.quiz, state.userSender, state.targetScore,
              state.battleCard);
        }
      },
      child: Container(
        width: 10,
        height: 10,
        color: redColor,
      ),
    );
  }
}
