import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/core.dart';
import 'package:skincare_recomendation/core/widgets/topography_painter.dart';

class PrimaryStats extends StatelessWidget {
  final int value;
  final String maxValue;

  const PrimaryStats({super.key, required this.value, required this.maxValue});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      color: context.colors.primaryContainer,
      showBorder: false,
      showShadow: false,
      borderRadius: AppRadius.br24,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: TopographyPainter(
                color: context.colors.onPrimaryContainer,
                opacity: 0.1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Indeks UV Saat Ini',
                  style: context.text.titleMedium?.copyWith(
                    color: context.colors.onPrimaryContainer.withValues(
                      alpha: .7,
                    ),
                  ),
                ),
                const Spacer(),
                RichText(
                  text: TextSpan(
                    style: context.text.displayLarge?.copyWith(
                      color: context.colors.onPrimaryContainer,
                    ),
                    children: [
                      TextSpan(text: '$value'),
                      TextSpan(
                        text: ' / $maxValue',
                        style: context.text.headlineSmall?.copyWith(
                          color: context.colors.onPrimaryContainer.withValues(
                            alpha: .7,
                          ),
                        ),
                      ),
                    ],
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
