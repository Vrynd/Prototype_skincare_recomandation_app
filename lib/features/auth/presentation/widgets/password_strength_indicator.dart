import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) return const SizedBox.shrink();

    final score = _calculateScore();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(4, (index) {
            return Expanded(
              child: Container(
                height: 6,
                margin: EdgeInsets.only(right: index < 3 ? 8 : 0),
                decoration: BoxDecoration(
                  color: _getBarColor(index, score, context),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Text(
          _getStrengthText(score),
          style: context.text.bodySmall?.copyWith(
            color: _getStrengthColor(score, context),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  int _calculateScore() {
    int score = 0;
    if (password.length >= 8) score++;
    if (RegExp(r'[a-z]').hasMatch(password)) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'\d').hasMatch(password)) score++;
    if (RegExp(r'[!@#\$&*~]').hasMatch(password)) score++;
    
    // Scale 5 points to 4 bars
    if (score == 0) return 0;
    if (score <= 2) return 1; // Weak
    if (score == 3) return 2; // Fair
    if (score == 4) return 3; // Good
    return 4; // Strong
  }

  Color _getBarColor(int index, int score, BuildContext context) {
    if (index >= score) return context.colors.outlineVariant.withValues(alpha: 0.3);
    
    switch (score) {
      case 1:
        return Colors.redAccent;
      case 2:
        return Colors.orangeAccent;
      case 3:
        return Colors.blueAccent;
      case 4:
        return context.colors.primary;
      default:
        return context.colors.outlineVariant;
    }
  }

  String _getStrengthText(int score) {
    switch (score) {
      case 1:
        return 'Sangat Lemah';
      case 2:
        return 'Cukup';
      case 3:
        return 'Kuat';
      case 4:
        return 'Sangat Kuat';
      default:
        return '';
    }
  }

  Color _getStrengthColor(int score, BuildContext context) {
    switch (score) {
      case 1:
        return Colors.redAccent;
      case 2:
        return Colors.orangeAccent;
      case 3:
        return Colors.blueAccent;
      case 4:
        return context.colors.primary;
      default:
        return context.colors.outlineVariant;
    }
  }
}
