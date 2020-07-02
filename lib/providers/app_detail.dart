import 'package:flutter/material.dart';

class AppDetailProvider {
  final String appName;
  final String appUrl;
  static const version = "1.0.0";
  const AppDetailProvider({@required this.appName, @required this.appUrl});
}
