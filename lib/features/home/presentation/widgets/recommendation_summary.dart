import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_radius.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';
import 'package:skincare_recomendation/features/home/presentation/widgets/topography_painter.dart';

class RecommendationSummary extends StatelessWidget {
  final int totalRecommendations;
  final int matchedProducts;

  const RecommendationSummary({
    super.key,
    required this.totalRecommendations,
    required this.matchedProducts,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'label': 'Total Rekomendasi',
        'value': '$totalRecommendations Kali',
        'icon': HugeIcons.strokeRoundedNote01,
        'iconColor': context.colors.primary,
      },
      {
        'label': 'Kecocokan Produk',
        'value': '$matchedProducts Produk',
        'icon': HugeIcons.strokeRoundedPackage,
        'iconColor': context.colors.tertiary,
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 8,
      children: items.map((item) {
        return _SummaryItem(
          label: item['label'] as String,
          value: item['value'] as String,
          icon: item['icon'],
          iconColor: item['iconColor'] as Color,
        );
      }).toList(),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final dynamic icon;
  final Color iconColor;

  const _SummaryItem({
    required this.label,
    required this.value,
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
              // Background Topography Texture
              Positioned.fill(
                child: CustomPaint(
                  painter: TopographyPainter(color: iconColor, opacity: 0.05),
                ),
              ),

              // Card Content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 16,
                  children: [
                    // Header: Label & Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 4,
                      children: [
                        Expanded(
                          child: Text(
                            label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.text.bodyMedium?.copyWith(
                              color: context.colors.onSurfaceVariant,
                            ),
                          ),
                        ),
                        HugeIcon(icon: icon, size: 20, color: iconColor),
                      ],
                    ),

                    // Value Text
                    Text(
                      value,
                      maxLines: 1,
                      style: context.text.headlineMedium?.copyWith(
                        color: context.colors.onSurface,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
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
