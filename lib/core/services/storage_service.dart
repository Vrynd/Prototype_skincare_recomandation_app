import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static const String keyReminderActive = 'is_uv_reminder_active';
  static const String keyFirstTime = 'is_first_time_user';

  Future<bool> setBool(String key, bool value) async {
    try {
      return await _prefs.setBool(key, value);
    } catch (e) {
      throw Exception('StorageService Error (setBool): $e');
    }
  }

  bool getBool(String key, {bool defaultValue = false}) {
    try {
      return _prefs.getBool(key) ?? defaultValue;
    } catch (e) {
      throw Exception('StorageService Error (getBool): $e');
    }
  }

  Future<bool> setString(String key, String value) async {
    try {
      return await _prefs.setString(key, value);
    } catch (e) {
      throw Exception('StorageService Error (setString): $e');
    }
  }

  String? getString(String key) {
    try {
      return _prefs.getString(key);
    } catch (e) {
      throw Exception('StorageService Error (getString): $e');
    }
  }

  Future<bool> remove(String key) async {
    try {
      return await _prefs.remove(key);
    } catch (e) {
      throw Exception('StorageService Error (remove): $e');
    }
  }

  Future<bool> clear() async {
    try {
      return await _prefs.clear();
    } catch (e) {
      throw Exception('StorageService Error (clear): $e');
    }
  }
}
