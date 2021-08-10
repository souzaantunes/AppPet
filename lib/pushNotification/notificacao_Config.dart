
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class NotificacaoConfig {
  static final FirebaseMessaging _fbm = FirebaseMessaging.instance;


  Future<void> configure() async{

    await _fbm.requestPermission(
      alert : true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('on message');
      print('Message data: ${message.data}');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print(message.data);
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    print('token ${_fbm.getToken()}');
  }

  static Future _firebaseMessagingHandler(Map<String, dynamic> message) async {
    await Firebase.initializeApp();
  }

  void _processMessage(message){
    _flutterLocalNotificationShow(message);
  }

  void _flutterLocalNotificationShow(message) {
    String payload;
    if (Platform.isIOS) {
      payload = message['payload'];
    } else {
      payload = message['data']['payload'];
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
  }
}
