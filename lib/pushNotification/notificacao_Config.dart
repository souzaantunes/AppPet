import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificacaoConfig {
  static final FirebaseMessaging _fbm = FirebaseMessaging.instance;
  NotificationDetails notificationDetails;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel;

  Future<void> configure() async {
    await Firebase.initializeApp();
    await _fbm.requestPermission(
      alert: true,
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
      _processMessage(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print(message.data);
      _processMessage(message);
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void _processMessage(message) {
    _flutterLocalNotificationShow(message);
  }

  void _flutterLocalNotificationShow(message) async {
    String payload;
    if (Platform.isIOS) {
      payload = message['payload'];
    } else {
      payload = message['data']['payload'];
    }
    await flutterLocalNotificationsPlugin.show(
        0,
        message['nitification']['title'],
        message['nitification']['body'],
        notificationDetails,
        payload: payload);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
  }

  Future<void> _createdChanel() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
}
