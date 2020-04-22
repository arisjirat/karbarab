import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:karbarab/features/battle/view/battle_screen.dart';
import 'package:karbarab/features/notification/bloc/notification_bloc.dart';
import 'package:rxdart/subjects.dart';

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

NotificationAppLaunchDetails notificationAppLaunchDetails;

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

class AppPushs extends StatefulWidget {
  AppPushs({
    @required this.child,
  });

  final Widget child;

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
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (ctx, s) async {
        // if (s is HaveNewBattleCard && s.hasNew) {
        //   await _flutterLocalNotificationsPlugin.cancelAll();
        //   BlocProvider.of<NotificationBloc>(context).add(ResetNotification());
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (ct) => const BattleScreen()),
        //   );
        // }
      },
      child: widget.child,
    );
  }

  void _initLocalNotifications() {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_stat_group');
    const initializationSettingsIOS = IOSInitializationSettings();
    const initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  Future _onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
    // BlocProvider.of<NotificationBloc>(context).add(OnPushNotification(payload));
    // Navigator.of(context)
    // .pushNamedAndRemoveUntil(BattleScreen.routeName, (Route<dynamic> route) => false);
    // Navigator.of(context).pushAndRemoveUntil(
    //                                       MaterialPageRoute(builder: (context) {
    //                                     return const BattleScreen();
    //                                   }), ModalRoute.withName('/'));
    // await Navigator.of(context).pus(
    //   context,
    //   MaterialPageRoute(builder: (context) => const BattleScreen()),
    // );
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      // await Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => SecondScreen(payload)),
      // );
      await Navigator.push(
            context,
            MaterialPageRoute(builder: (ct) => const BattleScreen()),
          );
    });
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _flutterLocalNotificationsPlugin.cancelAll();
  //   BlocProvider.of<NotificationBloc>(context).add(ResetNotification());
  // }

  void _initFirebaseMessaging() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('AppPushs onMessage : $message');
        _showNotification(message);
        return;
      },
      // onBackgroundMessage: Platform.isIOS ? null : backgroundMessageHandler,
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
      payloadQuizId = nodeData['quizId'];
      pushTitle = 'Hai kamu dapat kartu!';
      pushText = 'Coba jawab kaartu dari ${nodeData['usernameSender']}';
      type = nodeData['action'];
    } else {
      payloadQuizId = message['quizId'];
      pushTitle = 'Hai kamu dapat kartu!';
      pushText = 'Coba jawab kaartu dari ${message['usernameSender']}';
      type = message['type'];
    }
    print('AppPushs pushTitle : $pushTitle');
    print('AppPushs pushText : $pushText');
    print('AppPushs pushType : $type');

    final AndroidNotificationDetails platformChannelSpecificsAndroid =
        AndroidNotificationDetails(
      'karabarabChannelId',
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

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        pushTitle,
        pushText,
        platformChannelSpecifics,
        payload: payloadQuizId,
      );
    });
  }
}
