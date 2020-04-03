import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:karbarab/core/helper/log_printer.dart';
import 'package:karbarab/utils/logger.dart';

class NotificationFCM extends StatefulWidget {
  @override
  _NotificationFCMState createState() => _NotificationFCMState();
}

class _NotificationFCMState extends State<NotificationFCM> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final TextEditingController _controllerTopic = TextEditingController();
  String token = '';
  bool isSubscribed = false;

  @override
  void initState() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        Logger.w('onMessage');
        try {
          final data = message['data'];
          final String name = data['name'];
          final String age = data['age'];
          // getLogger('FCM').e('name: $name & age: $age');
        } catch (error) {
          // getLogger('FCM').e('error: $error');
        }
        return true;
      },

    );
    _firebaseMessaging.getToken().then((String token) {
      setState(() {
        this.token = token;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    // getLogger('FCM').e('token: $token');

    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: const Text('Flutter FCM'),
      ),
      body: SafeArea(
        child: Container(
          width: widthScreen,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Token',
                style: Theme.of(context).textTheme.title,
              ),
              SelectableText(
                token.isEmpty ? 'Getting value...' : token,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _controllerTopic,
                decoration: const InputDecoration(hintText: 'Enter topic'),
                enabled: !isSubscribed,
              ),
              const SizedBox(height: 8.0),
              Text('Subscribed: $isSubscribed'),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      child: const Text('Subscribe'),
                      onPressed: isSubscribed
                          ? null
                          : () {
                              final String topic = _controllerTopic.text;
                              if (topic.isEmpty) {
                                _scaffoldState.currentState
                                    .showSnackBar(const SnackBar(
                                  content: Text('Please enter topic'),
                                ));
                                return;
                              }
                              _firebaseMessaging.subscribeToTopic(topic);
                              setState(() {
                                isSubscribed = true;
                              });
                            },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: RaisedButton(
                      child: const Text('Unsubscribe'),
                      onPressed: !isSubscribed
                          ? null
                          : () {
                              final String topic = _controllerTopic.text;
                              _firebaseMessaging.unsubscribeFromTopic(topic);
                              setState(() {
                                isSubscribed = false;
                              });
                            },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// const DATA='{"notification":{"body":"Coba body gue","title":"Not Notification"},"priority":"high","data":{"name":"Joko Susilo Bambang","age":10},"to":"ddSozQSlZF4:APA91bGhbJjKRoYg1eq0kejOZj06zsuW1x-qu4kgHmp4V1OUJZSGzq-7d13DlQRE2mgGrXtwDemgXkiuEsj7Py4zF0FaZSprSNXp6niqw_6WHQV_cB1AotKF3RREv0ggACSwLRZ5QLlU"}';

// curl https://fcm.googleapis.com/fcm/send -H "Content-Type:application/json" -X POST -d "$DATA" -H "Authorization: key=AAAA72yGgSk:APA91bFbT_oq4xCPNqcEru-OXSZpCzDmNI6wKQ8CRkU5HLoaYjv7Xa1v-12e6kAM2en_dGFXc0_6I2h3cM-2zhF0mU_c4EqPi5RZ7uJ1h-CZc-NyUOiiZIPXuoZFyw_HEnYz_GB94yP6"