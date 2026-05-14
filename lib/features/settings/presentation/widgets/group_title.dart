import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';

class GroupTitle extends StatelessWidget {
  final String title;
  const GroupTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 8),
      child: Text(
        title.toUpperCase(),
        style: context.text.labelMedium?.copyWith(
          color: context.colors.onSurfaceVariant.withValues(alpha: 0.8),
        ),
      ),
    );
  }
}
