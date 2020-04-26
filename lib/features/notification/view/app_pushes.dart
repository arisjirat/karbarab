import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:karbarab/features/battle/view/battle_screen.dart';
import 'package:karbarab/model/notification_queue.dart';
import 'package:karbarab/repository/notification_repository.dart';
import 'package:karbarab/utils/logger.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

NotificationAppLaunchDetails notificationAppLaunchDetails;

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
const NOTIFICATION_QUEUE_PREFERENCE = 'notification_queue';

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
    final SharedPreferences prefs = await _prefs;
    try {
      final NotificationQueue payloadQueue = NotificationRepository.fromJson(
        jsonDecode(payload),
      );
      final List<String> listQueue = prefs.getStringList(
            NOTIFICATION_QUEUE_PREFERENCE,
          ) ??
          [];
      if (listQueue.isEmpty) {
        return;
      }
      final int indexOfPayload = listQueue.indexWhere((q) {
        final NotificationQueue notificationQueue =
            NotificationRepository.fromJson(jsonDecode(q));
        return notificationQueue.id == payloadQueue.id;
      });
      listQueue.removeWhere((q) {
        final NotificationQueue notificationQueue =
            NotificationRepository.fromJson(jsonDecode(q));
        return notificationQueue.id == payloadQueue.id;
      });
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
        selectNotificationSubject.add(payload);
      }
      await prefs.setStringList(NOTIFICATION_QUEUE_PREFERENCE, listQueue);
      _flutterLocalNotificationsPlugin.cancel(indexOfPayload);
    } catch (e) {
      await prefs.setStringList(NOTIFICATION_QUEUE_PREFERENCE, []);
      Logger.e('Failed notification select', s: StackTrace.current, e: e);
    }
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      widget.navigatorKey.currentState.pushNamed(BattleScreen.routeName);
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
    Map<String, dynamic> payload;
    if (Platform.isAndroid) {
      payload = Map<String, dynamic>.from(message['data']);
    } else {
      payload = Map<String, dynamic>.from(message);
    }
    final NotificationQueue notificationQueue =
        NotificationRepository.fromJson(payload);

    // ActionTypeNotification type;
    final String pushTitle = notificationQueue.title;
    final String pushText = notificationQueue.message;

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

    const platformChannelSpecificsIos = IOSNotificationDetails(
      presentSound: false,
    );
    final platformChannelSpecifics = NotificationDetails(
      platformChannelSpecificsAndroid,
      platformChannelSpecificsIos,
    );

    final SharedPreferences prefs = await _prefs;
    final List<String> listQueue = prefs.getStringList(
          NOTIFICATION_QUEUE_PREFERENCE,
        ) ??
        [];

    listQueue.add(jsonEncode(NotificationRepository.toMap(notificationQueue)));
    await prefs.setStringList(
      NOTIFICATION_QUEUE_PREFERENCE,
      listQueue,
    );
    await _flutterLocalNotificationsPlugin.show(
      listQueue.length,
      pushTitle,
      pushText,
      platformChannelSpecifics,
      payload: jsonEncode(NotificationRepository.toMap(notificationQueue)),
    );
  }
}
