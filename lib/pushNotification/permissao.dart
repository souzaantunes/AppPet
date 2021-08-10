import 'package:firebase_messaging/firebase_messaging.dart';

class Permissao {
  static final FirebaseMessaging fr = FirebaseMessaging.instance;

  Future<void> get permissoes {
    fr.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
