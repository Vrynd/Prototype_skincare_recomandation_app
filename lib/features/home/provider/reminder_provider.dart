import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/core.dart';

class ReminderProvider extends ChangeNotifier {
  final StorageService _storageService;

  bool _isActive = true;
  bool get isActive => _isActive;

  ReminderProvider(this._storageService) {
    _loadFromPrefs();
  }

  void _loadFromPrefs() {
    try {
      _isActive = _storageService.getBool(
        StorageService.keyReminderActive,
        defaultValue: true,
      );
    } catch (_) {
      _isActive = true;
    }
    notifyListeners();
  }

  Future<void> toggleReminder(bool value) async {
    if (_isActive == value) return;

    final oldValue = _isActive;
    _isActive = value;
    notifyListeners();

    try {
      await _storageService.setBool(StorageService.keyReminderActive, value);
    } catch (e) {
      _isActive = oldValue;
      notifyListeners();
    }
  }
}
