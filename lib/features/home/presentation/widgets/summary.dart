import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_radius.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';
import 'package:skincare_recomendation/features/home/models/skin_summary_model.dart';
import 'package:skincare_recomendation/features/home/presentation/widgets/topography_painter.dart';

class Summary extends StatelessWidget {
  final SkinSummaryModel data;

  const Summary({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 8,
      children: [
        _SummaryItem(
          label: 'Jenis Kulit',
          value: data.skinType,
          lastUpdated: data.lastUpdated,
          icon: HugeIcons.strokeRoundedDroplet,
          iconColor: context.colors.primary,
        ),
        _SummaryItem(
          label: 'Masalah Kulit',
          value: data.skinCondition,
          lastUpdated: data.lastUpdated,
          icon: HugeIcons.strokeRoundedActivity03,
          iconColor: context.colors.tertiary,
        ),
      ],
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final String lastUpdated;
  final dynamic icon;
  final Color iconColor;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.lastUpdated,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppContainer(
        showShadow: false,
        opacity: 0.8,
        borderRadius: AppRadius.br24,
        padding: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: AppRadius.br24,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: TopographyPainter(
                    color: context.colors.onSurfaceVariant,
                    opacity: 0.06,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                    _ItemHeader(
                      label: label,
                      icon: icon,
                      iconColor: iconColor,
                    ),
                    _ItemValue(
                      value: value,
                      lastUpdated: lastUpdated,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemHeader extends StatelessWidget {
  final String label;
  final dynamic icon;
  final Color iconColor;

  const _ItemHeader({
    required this.label,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: context.text.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
        HugeIcon(icon: icon, size: 20, color: iconColor),
      ],
    );
  }
}

class _ItemValue extends StatelessWidget {
  final String value;
  final String lastUpdated;

  const _ItemValue({
    required this.value,
    required this.lastUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        Text(
          value,
          maxLines: 1,
          style: context.text.headlineMedium?.copyWith(
            color: context.colors.onSurface,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          'Terakhir, $lastUpdated',
          style: context.text.labelSmall?.copyWith(
            color: context.colors.onSurfaceVariant.withValues(alpha: .5),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
