import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_divider.dart';

/// Widget pembatas sosial 'atau login dengan'
class SocialDivider extends StatelessWidget {
  final String title;
  const SocialDivider({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          Expanded(
            child: AppDivider.dashed(
              thickness: .8,
              color: context.colors.onSurfaceVariant.withValues(alpha: 0.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              title,
              style: context.text.bodyMedium?.copyWith(
                color: context.colors.onSurfaceVariant.withValues(alpha: .6),
              ),
            ),
          ),
          Expanded(
            child: AppDivider.dashed(
              thickness: .8,
              color: context.colors.onSurfaceVariant.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
