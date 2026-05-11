import 'package:flutter/material.dart';

class LastRecomendationModel {
  final String brandName;
  final String productName;
  final String category;
  final double uvIndex;
  final DateTime createdAt;

  LastRecomendationModel({
    required this.brandName,
    required this.productName,
    required this.category,
    required this.uvIndex,
    required this.createdAt,
  });

  Color get uvColor {
    if (uvIndex <= 2) return Colors.green;
    if (uvIndex <= 5) return Colors.orangeAccent;
    if (uvIndex <= 7) return Colors.orange;
    if (uvIndex <= 10) return Colors.red;
    return Colors.purple;
  }
}
