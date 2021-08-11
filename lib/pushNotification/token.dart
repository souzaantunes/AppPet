import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Token {
  static final FirebaseMessaging _fbm = FirebaseMessaging.instance;

  String _token;
  Stream<String> _tokenStream;
  // Message message = Message.builder()
  //     .putData("score", "850")
  //     .putData("time", "2:45")
  //     .setToken(registrationToken)
  //     .build();
  String setToken(String token) {
    // _fbm.sendMessage()
    print('chegou no set $token');
    this._token = token;
    // print("segundo token $_token");
    return _token;
  }

  Future<String> gerarToken() {
  return  _fbm.getToken().then(setToken);
    // _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    // _tokenStream.listen(setToken);
  }

  String get token{
    return _token;
  }


}
