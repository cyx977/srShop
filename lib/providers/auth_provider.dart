import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:srShop/models/exception_model.dart';

class AuthProvider extends ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Map<String, dynamic> get getAuth {
    return {
      "token": _token,
      "expiryDate": _expiryDate,
      "userId": _userId,
    };
  }

  bool get isAuth {
    if (_token != null &&
        DateTime.now().isBefore(_expiryDate) &&
        _userId != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _authenticate({
    @required String email,
    @required String password,
    @required String method,
  }) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$method?key=AIzaSyC-P8GGQ-DEGkp4CK7fcCTrrxqq7BwpCZo";
    Map<String, dynamic> responseJson;
    try {
      var response = await http.post(
        url,
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "password": password,
          "returnSecureToken": true,
        }),
      );
      responseJson = jsonDecode(response.body);
      if (!responseJson.containsKey('error')) {
        _token = responseJson['idToken'];
        _expiryDate = DateTime.now().add(
          Duration(
            seconds: int.parse(
              responseJson['expiresIn'],
            ),
          ),
        );
        _userId = responseJson['localId'];
      }
      if (responseJson.containsKey('error') ||
          _token == null ||
          _expiryDate == null ||
          _userId == null) {
        throw HttpException(
            message: responseJson['error']['errors'][0]['message']);
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw HttpException(
          message: responseJson['error']['errors'][0]['message']);
    }
    return;
  }

  Future<void> signup({String email, String password}) async {
    return _authenticate(
      email: email,
      password: password,
      method: 'signUp',
    );
  }

  Future<void> login({String email, String password}) async {
    return _authenticate(
      email: email,
      password: password,
      method: 'signInWithPassword',
    );
  }

  void logout() {
    _token = null;
    _expiryDate = null;
    _userId = null;
    notifyListeners();
  }
}
