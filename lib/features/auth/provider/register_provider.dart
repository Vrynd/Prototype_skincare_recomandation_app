import 'package:flutter/material.dart';

class PasswordIndicatorProvider extends ChangeNotifier {
  String _password = '';
  String get password => _password;

  void setPassword(String value) {
    if (_password != value) {
      _password = value;
      notifyListeners();
    }
  }
}
