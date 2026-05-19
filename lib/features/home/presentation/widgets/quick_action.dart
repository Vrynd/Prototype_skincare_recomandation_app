import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_radius.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';

class QuickAction extends StatelessWidget {
  final void Function(String title) onItemTap;
  const QuickAction({super.key, required this.onItemTap});

  static const List<Map<String, dynamic>> _items = [
    {
      'title': 'Kenali Kulitmu',
      'icon': HugeIcons.strokeRoundedFaceId,
      'isComingSoon': true,
    },
    {
      'title': 'Dapatkan Rekomendasi',
      'icon': HugeIcons.strokeRoundedPuzzle,
      'isComingSoon': false,
    },
    {
      'title': 'Rutinitas Harian',
      'icon': HugeIcons.strokeRoundedTaskDaily02,
      'isComingSoon': true,
    },
    {
      'title': 'Preferensi Kulit',
      'icon': HugeIcons.strokeRoundedSlidersHorizontal,
      'isComingSoon': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.46,
      children: _items.map((item) {
        final title = item['title'] as String;
        final icon = item['icon'];
        final isComingSoon = item['isComingSoon'] as bool;

        return _QuickActionItem(
          title: title,
          icon: icon,
          isComingSoon: isComingSoon,
          onTap: isComingSoon ? null : () => onItemTap(title),
        );
      }).toList(),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final String title;
  final dynamic icon;
  final bool isComingSoon;
  final VoidCallback? onTap;

  const _QuickActionItem({
    required this.title,
    required this.icon,
    required this.isComingSoon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      opacity: 0.8,
      borderRadius: AppRadius.br24,
      showShadow: false,
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.br24,
        child: Stack(
          children: [
            // Background Radial Gradients
            Positioned(
              top: -40,
              left: -20,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      context.colors.lime.withValues(alpha: 0.7),
                      context.colors.lime.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -20,
              right: -30,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      context.colors.yellow.withValues(alpha: 0.5),
                      context.colors.yellow.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),

            // Coming Soon Badge
            if (isComingSoon)
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.primaryContainer,
                    borderRadius: AppRadius.br8,
                  ),
                  child: Text(
                    "Segera",
                    style: context.text.labelSmall?.copyWith(
                      color: context.colors.onSecondaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            // Content (Icon & Text)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.colors.onSurfaceVariant.withValues(
                          alpha: 0.05,
                        ),
                      ),
                      child: Center(
                        child: HugeIcon(
                          icon: icon,
                          size: 22,
                          color: context.colors.onSurface,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    title.replaceAll(' ', '\n'),
                    style: context.text.titleMedium?.copyWith(
                      color: context.colors.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
