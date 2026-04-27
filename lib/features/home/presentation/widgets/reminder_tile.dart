import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/core.dart';

class ReminderTile extends StatelessWidget {
  final bool isActive;
  final ValueChanged<bool> onChanged;

  const ReminderTile({
    super.key,
    required this.isActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            spacing: 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sunscreen Reminder',
                style: context.text.titleMedium?.copyWith(
                  color: context.colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                isActive ? 'Setiap 2 jam' : 'Nonaktif',
                style: context.text.bodyMedium?.copyWith(
                  color: isActive
                      ? context.colors.primary
                      : context.colors.outline,
                ),
              ),
            ],
          ),
          Switch.adaptive(
            value: isActive,
            activeTrackColor: context.colors.primary.withValues(alpha: .5),
            activeThumbColor: context.colors.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
