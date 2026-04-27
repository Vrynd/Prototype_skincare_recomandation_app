import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/core.dart';
import 'package:skincare_recomendation/features/home/presentation/widgets/primary_stats.dart';
import 'package:skincare_recomendation/features/home/presentation/widgets/secondary_stats.dart';

class StatsOverview extends StatelessWidget {
  final int value;
  final String maxValue;
  final String category;
  final String airQuality;

  const StatsOverview({
    super.key,
    required this.value,
    required this.maxValue,
    required this.category,
    required this.airQuality,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      borderRadius: AppRadius.br24,
      padding: const EdgeInsets.all(20),
      showShadow: false,
      child: Stack(
        children: [
          Row(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(flex: 2, child: SizedBox()),
              Expanded(
                flex: 2,
                child: Column(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SecondaryStats(title: 'Kategori', value: category),
                    SecondaryStats(
                      title: 'Kualitas Udara',
                      value: airQuality,
                      type: StatsType.airQuality,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  flex: 2,
                  child: PrimaryStats(value: value, maxValue: maxValue),
                ),
                const Expanded(flex: 2, child: SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
