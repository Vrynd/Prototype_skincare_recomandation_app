import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/core.dart';
import 'package:skincare_recomendation/features/home/presentation/widgets/reminder_tile.dart';
import 'package:skincare_recomendation/features/home/presentation/widgets/stats_overview.dart';

class IndexUvCard extends StatelessWidget {
  final int value;
  final String maxValue;
  final String category;
  final String airQuality;
  final bool isReminder;
  final ValueChanged<bool> onReminderChanged;

  const IndexUvCard({
    super.key,
    required this.value,
    required this.maxValue,
    required this.category,
    required this.airQuality,
    required this.isReminder,
    required this.onReminderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      opacity: 0.6,
      borderRadius: AppRadius.br24,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          StatsOverview(
            value: value,
            maxValue: maxValue,
            category: category,
            airQuality: airQuality,
          ),
          ReminderTile(
            isActive: isReminder,
            onChanged: onReminderChanged,
          ),
        ],
      ),
    );
  }
}
