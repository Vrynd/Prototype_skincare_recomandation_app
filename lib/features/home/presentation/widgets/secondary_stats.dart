import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/core.dart';

enum StatsType { category, airQuality }

class SecondaryStats extends StatelessWidget {
  final String title;
  final String value;
  final StatsType type;

  const SecondaryStats({
    super.key,
    required this.title,
    required this.value,
    this.type = StatsType.category,
  });

  @override
  Widget build(BuildContext context) {
    final icon = type == StatsType.airQuality
        ? HugeIcons.strokeRoundedCloudFastWind
        : HugeIcons.strokeRoundedSun03;

    final iconColor = type == StatsType.airQuality
        ? const Color(0xFF2E7D32)
        : Colors.orange;

    return AppContainer(
      borderColor: context.colors.outlineVariant.withValues(alpha: .3),
      showShadow: false,
      borderRadius: AppRadius.br20,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned(
            bottom: -5,
            right: -5,
            child: HugeIcon(
              icon: icon,
              color: iconColor.withValues(alpha: .2),
              size: 56,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.text.titleSmall?.copyWith(
                    color: context.colors.outline,
                  ),
                ),
                AppSpacing.v8,
                Text(
                  value,
                  style: context.text.titleLarge?.copyWith(
                    color: context.colors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
