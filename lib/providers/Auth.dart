import 'dart:convert';
import 'dart:async';

import 'package:app/data/store.dart';
import 'package:app/exceptions/auth_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _userId;
  Timer _logoutTimer;
  String _token;
  DateTime _expiryDate;

  String get userId {
    return isAuth ? _userId : null;
  }

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    } else {
      return null;
    }
  }

  Future<void> _authenticate(String email, String password, String urlSegment) async {
    final _url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCpbKnxN2nrVMlLWa5U9ya7_N6CU69_4S4';

    final response = await http.post(
      _url,
      body: jsonEncode({
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }),
    );
    final responseBody = jsonDecode(response.body);
    if (responseBody["error"] != null) {
      throw AuthException(responseBody['error']['message']);
    } else {
      _token = responseBody["idToken"];
      _userId = responseBody["localId"];
      _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(responseBody["expiresIn"]),),);
      Store.saveMap('userData', {
        "token": _token,
        "user": _userId,
        "expiryDate": _expiryDate.toIso8601String(),
      });
      _autoLogout();
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) {
      return Future.value();
    }
    final userDate = await Store.getMap('userDate');

    if (userDate == null) {
      return Future.value();
    }

    final expiryDate = DateTime.parse(userDate['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return Future.value();
    }
    _userId = userDate["userId"];
    _token = userDate["token"];
    _expiryDate = expiryDate;

    _autoLogout();
    notifyListeners();

    return Future.value();
  }

  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_logoutTimer != null) {
      _logoutTimer.cancel();
      _logoutTimer = null;
    }
    Store.remove('userDate');
    notifyListeners();
  }

  void _autoLogout() {
    if (_logoutTimer != null) {
      _logoutTimer.cancel();
    }

    final timeToLogout = _expiryDate.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: timeToLogout), logout);
  }
}
