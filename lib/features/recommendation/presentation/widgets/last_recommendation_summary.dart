import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';
import 'package:skincare_recomendation/core/widgets/app_tile.dart';
import 'package:skincare_recomendation/features/recommendation/model/last_recommendation_model.dart';

class LastRecommendationSummary extends StatelessWidget {
  final LastRecommendationModel? data;

  const LastRecommendationSummary({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final String displayDate = data?.lastDate ?? 'Belum ada data';

    final Color? dateValueColor = data?.lastDate == null
        ? context.colors.outline.withValues(alpha: 0.5)
        : null;

    final skinMetrics = [
      (
        icon: HugeIcons.strokeRoundedDroplet,
        title: 'Jenis Kulit',
        value: data?.skinType ?? 'Belum ada data',
        valueColor: data?.skinType == null
            ? context.colors.outline.withValues(alpha: 0.5)
            : null,
      ),
      (
        icon: HugeIcons.strokeRoundedActivity03,
        title: 'Masalah Kulit',
        value: data?.skinConcern ?? 'Belum ada data',
        valueColor: data?.skinConcern == null
            ? context.colors.outline.withValues(alpha: 0.5)
            : null,
      ),
      (
        icon: HugeIcons.strokeRoundedSun01,
        title: 'Indeks Ultraviolet',
        value: data?.uvIndex ?? 'Belum ada data',
        valueColor: data?.uvIndex == null
            ? context.colors.outline.withValues(alpha: 0.5)
            : null,
      ),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: [
        AppContainer(
          padding: EdgeInsets.zero,
          showShadow: false,
          opacity: 0.8,
          child: Column(
            children: List.generate(skinMetrics.length, (index) {
              final metric = skinMetrics[index];

              return AppTile.modern(
                icon: metric.icon,
                iconColor: context.colors.tertiary,
                title: metric.title,
                value: metric.value,
                valueColor: metric.valueColor,
                showDivider: index < skinMetrics.length - 1,
              );
            }),
          ),
        ),

        AppContainer(
          padding: EdgeInsets.zero,
          showShadow: false,
          opacity: 0.8,
          child: AppTile.modern(
            icon: HugeIcons.strokeRoundedCalendar01,
            iconColor: context.colors.tertiary,
            title: 'Terakhir',
            value: displayDate,
            valueColor: dateValueColor,
          ),
        ),
      ],
    );
  }
}
