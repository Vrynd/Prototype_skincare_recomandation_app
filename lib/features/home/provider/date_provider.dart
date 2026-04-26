import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:skincare_recomendation/core/utils/app_helpers.dart';

class DateProvider extends ChangeNotifier {
  String _date = AppHelpers.formatDateFallback();
  Timer? _dailyTimer;
  bool _isInitialized = false;

  String get date => _date;

  DateProvider() {
    _init();
  }

  Future<void> _init() async {
    if (_isInitialized) return;
    
    try {
      await initializeDateFormatting('id_ID', null);
      _updateDate();
      _isInitialized = true;
    } catch (e) {
      debugPrint('Error initializing date formatting: $e');
    } finally {
      _scheduleNextUpdate();
    }
  }

  void _updateDate() {
    _date = AppHelpers.formatDate();
    notifyListeners();
  }

  void _scheduleNextUpdate() {
    _dailyTimer?.cancel();

    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1, 0, 0, 1);
    final durationToMidnight = nextMidnight.difference(now);

    _dailyTimer = Timer(durationToMidnight, () {
      _updateDate();
      _scheduleNextUpdate(); 
    });
  }

  @override
  void dispose() {
    _dailyTimer?.cancel();
    super.dispose();
  }
}
