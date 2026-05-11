import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/themes/app_radius.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';
import 'package:skincare_recomendation/features/home/models/uv_index_model.dart';

class IndexUV extends StatelessWidget {
  final UvIndexModel data;

  const IndexUV({super.key, required this.data});

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
          _UvHeader(status: data.currentStatus),
          _UvBody(
            currentUv: data.currentUv,
            forecastUv: data.forecastUv,
            activeIndex: data.activeIndex,
          ),
        ],
      ),
    );
  }
}

class _UvHeader extends StatelessWidget {
  final UvStatus status;

  const _UvHeader({required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Indeks Ultraviolet',
          style: context.text.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
        _StatusBadge(status: status),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final UvStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      width: null,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      color: status.color,
      opacity: 0.1,
      borderRadius: AppRadius.br16,
      borderColor: status.color.withValues(alpha: 0.2),
      showShadow: false,
      child: Text(
        status.label,
        style: context.text.bodySmall?.copyWith(
          color: status.color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _UvBody extends StatelessWidget {
  final int currentUv;
  final List<int> forecastUv;
  final int activeIndex;

  const _UvBody({
    required this.currentUv,
    required this.forecastUv,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _CurrentUvValue(value: currentUv),
        _ForecastBars(
          forecastUv: forecastUv,
          activeIndex: activeIndex,
        ),
      ],
    );
  }
}

class _CurrentUvValue extends StatelessWidget {
  final int value;

  const _CurrentUvValue({required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: context.text.displayMedium?.copyWith(
          color: context.colors.onSurface,
          fontSize: 48,
          height: 1.0,
        ),
        children: [
          TextSpan(text: '$value'),
          TextSpan(
            text: ' / 11',
            style: context.text.headlineSmall?.copyWith(
              color: context.colors.outline.withValues(alpha: 0.5),
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _ForecastBars extends StatelessWidget {
  final List<int> forecastUv;
  final int activeIndex;

  const _ForecastBars({
    required this.forecastUv,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    final days = ['S', 'S', 'R', 'K', 'J', 'S', 'M'];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(forecastUv.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(left: 8),
          child: _UvBarItem(
            uvValue: forecastUv[index],
            day: days[index % 7],
            isActive: index == activeIndex,
          ),
        );
      }),
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
