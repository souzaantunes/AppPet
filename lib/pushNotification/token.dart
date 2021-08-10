import 'package:firebase_messaging/firebase_messaging.dart';

class Token {
  static final FirebaseMessaging _fbm = FirebaseMessaging.instance;

  Token(this._token);

  String _token;
  Stream<String> _tokenStream;

  void setToken(String token) {
    print('FCM Token: $token');
    _token = token;
  }

  void gerarToken() {
    _fbm.getToken(vapidKey: '').then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);
  }

  String get token {
    return _token;
  }
}
