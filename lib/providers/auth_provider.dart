import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  String _token;
  String _expiryDate;
  String _userId;

  Map<String, dynamic> get getAuth {
    return {
      "token": _token,
      "expiryDate": _expiryDate,
      "userId": _userId,
    };
  }

  Future<void> signup({String email, String password}) async {
    const url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyC-P8GGQ-DEGkp4CK7fcCTrrxqq7BwpCZo";
    var response = await http.post(
      url,
      body: jsonEncode(<String, dynamic>{
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }),
    );
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    print(responseJson);
    _token = responseJson['idToken'];
    _expiryDate = responseJson['refreshToken'];
    _userId = responseJson['localId'];
    notifyListeners();
  }
}
