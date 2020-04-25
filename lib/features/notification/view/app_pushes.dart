import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:karbarab/features/battle/view/battle_screen.dart';
import 'package:karbarab/model/score.dart';
import 'package:rxdart/subjects.dart';
// import 'package:karbarab/features/home/view/home_screen.dart';

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

NotificationAppLaunchDetails notificationAppLaunchDetails;


class AppPushs extends StatefulWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  AppPushs({@required this.child, @required this.navigatorKey});

  @override
  _AppPushsState createState() => _AppPushsState();
}

class _AppPushsState extends State<AppPushs> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _initLocalNotifications();
    _initFirebaseMessaging();
    _configureSelectNotificationSubject();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _initLocalNotifications() {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_stat_group');
    const initializationSettingsIOS = IOSInitializationSettings();
    const initializationSettings = InitializationSettings(
      initializationSettingsAndroid,
      initializationSettingsIOS,
    );
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: _onSelectNotification,
    );
  }

  Future _onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
      selectNotificationSubject.add(payload);
    }
    _flutterLocalNotificationsPlugin.cancel(0);
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      widget.navigatorKey.currentState.pushNamed(BattleScreen.routeName);
      // widget.navigatorKey.currentState.pushNamed(HomeScreen.routeName);
    });
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  void _initFirebaseMessaging() {
    if (!kReleaseMode) {
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) {
          print('AppPushs onMessage : $message');
          _showNotification(message);
          return;
        },
        onResume: (Map<String, dynamic> message) {
          print('AppPushs onResume : $message');
          if (Platform.isIOS) {
            _showNotification(message);
          }
          return;
        },
        onLaunch: (Map<String, dynamic> message) {
          print('AppPushs onLaunch : $message');
          return;
        },
      );
    } else {  
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) {
          _showNotification(message);
          return;
        },
        onBackgroundMessage: Platform.isIOS ? null : backgroundMessageHandler,
        onResume: (Map<String, dynamic> message) {
          if (Platform.isIOS) {
            _showNotification(message);
          }
          return;
        },
        onLaunch: (Map<String, dynamic> message) {
          return;
        },
      );
    }
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  static Future<dynamic> backgroundMessageHandler(
    Map<String, dynamic> message,
  ) {
    _showNotification(message);
    return Future<void>.value();
  }

  static Future _showNotification(Map<String, dynamic> message) async {
    String pushTitle;
    String pushText;
    String type;
    String payloadQuizId;

    if (Platform.isAndroid) {
      final nodeData = message['data'];
      type = nodeData['type'];
      payloadQuizId = nodeData['quizId'];
      final usernameSender = nodeData[USERNAME_SENDER];
      if (type == 'ANSWER_BATTLE') {
        pushTitle = 'Hai $usernameSender sudah menjawab!';
        pushText = '${nodeData['message']}';
      } else {
        pushTitle = 'Hai kamu dapat kartu!';
        pushText = 'Coba jawab kartu dari $usernameSender';
      }
    } else {
      type = message['type'];
      payloadQuizId = message['quizId'];
      final usernameSender = message[USERNAME_SENDER];
      if (type == 'ANSWER_BATTLE') {
        pushTitle = 'Hai $usernameSender sudah menjawab!';
        pushText = '${message['message']}';
      } else {
        pushTitle = 'Hai kamu dapat kartu!';
        pushText = 'Coba jawab kartu dari $usernameSender';
      }
    }

    final AndroidNotificationDetails platformChannelSpecificsAndroid =
        AndroidNotificationDetails(
      'com.pasdigital.karbarab',
      'Perang Kartu',
      'Pemberitahuan Kartu yang dikirim dari lawan',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );

    const platformChannelSpecificsIos =
        IOSNotificationDetails(presentSound: false);
    final platformChannelSpecifics = NotificationDetails(
        platformChannelSpecificsAndroid, platformChannelSpecificsIos);

    await _flutterLocalNotificationsPlugin.show(
      0,
      pushTitle,
      pushText,
      platformChannelSpecifics,
      payload: payloadQuizId,
    );
  }
}
