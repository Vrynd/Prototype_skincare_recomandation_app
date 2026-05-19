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
    if (uv <= 2) return UvStatus('Rendah', Colors.green);
    if (uv <= 5) return UvStatus('Sedang', Colors.orange);
    if (uv <= 7) return UvStatus('Tinggi', Colors.redAccent);
    if (uv <= 10) return UvStatus('Sangat Tinggi', Colors.red);
    return UvStatus('Ekstrem', Colors.purple);
  }
}

class UvStatus {
  final String label;
  final Color color;
  UvStatus(this.label, this.color);
}
