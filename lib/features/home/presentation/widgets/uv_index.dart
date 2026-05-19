import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/themes/app_radius.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_badge.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';
import 'package:skincare_recomendation/features/home/models/uv_index_model.dart';

class UvIndex extends StatelessWidget {
  final UvIndexModel data;
  final String location;

  const UvIndex({
    super.key,
    required this.data,
    this.location = 'Yogyakarta, Indonesia',
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      opacity: 0.8,
      showShadow: false,
      borderRadius: AppRadius.br24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                location,
                style: context.text.bodyMedium?.copyWith(
                  color: context.colors.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppBadge.tonal(
                label: data.currentStatus.label,
                color: data.currentStatus.color,
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  style: context.text.displayMedium?.copyWith(
                    color: context.colors.onSurface,
                    fontSize: 48,
                    height: 1.0,
                  ),
                  children: [
                    TextSpan(text: '${data.currentUv}'),
                    TextSpan(
                      text: ' / 11',
                      style: context.text.headlineSmall?.copyWith(
                        color: context.colors.outline.withValues(alpha: 0.5),
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(data.forecastUv.length, (index) {
                  final days = ['S', 'S', 'R', 'K', 'J', 'S', 'M'];
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: _UvBarItem(
                      uvValue: data.forecastUv[index],
                      day: days[index % 7],
                      isActive: index == data.activeIndex,
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UvBarItem extends StatelessWidget {
  final int uvValue;
  final String day;
  final bool isActive;

  const _UvBarItem({
    required this.uvValue,
    required this.day,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    const maxHeight = 100.0;
    final barHeight = (uvValue / 11) * maxHeight;

    return AppContainer(
      height: maxHeight,
      width: 24,
      padding: EdgeInsets.zero,
      color: context.colors.surfaceContainerHigh,
      opacity: 0.5,
      borderRadius: AppRadius.br32,
      showBorder: false,
      showShadow: false,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AppContainer(
            height: barHeight < 24 ? 24 : barHeight,
            width: 24,
            padding: EdgeInsets.zero,
            color: context.colors.primary,
            opacity: isActive ? 1.0 : 0.4,
            borderRadius: AppRadius.br32,
            showBorder: false,
            showShadow: false,
            child: isActive
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: AppContainer(
                        width: 8,
                        height: 8,
                        padding: EdgeInsets.zero,
                        color: context.colors.surface,
                        shape: BoxShape.circle,
                        showBorder: false,
                        showShadow: false,
                      ),
                    ),
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              day,
              style: context.text.labelMedium?.copyWith(
                color: context.colors.surface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
