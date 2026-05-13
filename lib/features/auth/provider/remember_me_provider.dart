import 'package:flutter/material.dart';

class RememberMeProvider extends ChangeNotifier {
  bool _isRememberMe = false;

  bool get isRememberMe => _isRememberMe;

  void toggleRememberMe() {
    _isRememberMe = !_isRememberMe;
    notifyListeners();
  }

  void setRememberMe(bool value) {
    _isRememberMe = value;
    notifyListeners();
  }
}
