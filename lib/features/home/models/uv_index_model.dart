import 'package:flutter/material.dart';

class UvIndexModel {
  final int currentUv;
  final List<int> forecastUv;
  final int activeIndex;

  UvIndexModel({
    required this.currentUv,
    required this.forecastUv,
    this.activeIndex = 0,
  });

  UvStatus get currentStatus => getUvStatus(currentUv);

  static UvStatus getUvStatus(int uv) {
    if (uv <= 2) return UvStatus('Low', Colors.green);
    if (uv <= 5) return UvStatus('Moderate', Colors.orange);
    if (uv <= 7) return UvStatus('High', Colors.redAccent);
    if (uv <= 10) return UvStatus('Very High', Colors.red);
    return UvStatus('Extreme', Colors.purple);
  }
}

class UvStatus {
  final String label;
  final Color color;
  UvStatus(this.label, this.color);
}
