import 'package:flutter/material.dart';

class UVIndex {
  final double index;
  final String label;
  final Color color;

  const UVIndex({
    required this.index,
    required this.label,
    required this.color,
  });

  // Global UV Index Colors
  static const Color low = Color(0xFF4EB400);
  static const Color moderate = Color(0xFFF7E400);
  static const Color high = Color(0xFFF88700);
  static const Color veryHigh = Color(0xFFD8001D);
  static const Color extreme = Color(0xFFB54CFF);

  factory UVIndex.fromIndex(double index) {
    return UVIndex(
      index: index,
      label: getLabel(index),
      color: getColor(index),
    );
  }

  static Color getColor(double index) {
    if (index < 3) return low;
    if (index < 6) return moderate;
    if (index < 8) return high;
    if (index < 11) return veryHigh;
    return extreme;
  }

  static String getLabel(double index) {
    if (index < 3) return 'Rendah';
    if (index < 6) return 'Sedang';
    if (index < 8) return 'Tinggi';
    if (index < 11) return 'Sangat Tinggi';
    return 'Ekstrim';
  }
}
