import 'package:flutter/material.dart';

class QuickActionModel {
  final String title;
  final dynamic icon;
  final bool isComingSoon;
  final VoidCallback? onTap;

  const QuickActionModel({
    required this.title,
    required this.icon,
    this.isComingSoon = false,
    this.onTap,
  });
}
