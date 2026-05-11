import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_radius.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';
import 'package:skincare_recomendation/features/home/models/quick_action_model.dart';

class QuickAction extends StatelessWidget {
  final List<QuickActionModel> data;
  final void Function(int index) onItemTap;

  const QuickAction({
    super.key,
    required this.data,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    final List<Widget> rows = [];
    for (int i = 0; i < data.length; i += 2) {
      rows.add(
        Row(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            _QuickActionItem(
              data: data[i],
              onTap: data[i].isComingSoon ? null : () => onItemTap(i),
            ),
            if (i + 1 < data.length)
              _QuickActionItem(
                data: data[i + 1],
                onTap:
                    data[i + 1].isComingSoon ? null : () => onItemTap(i + 1),
              )
            else
              const Expanded(flex: 2, child: SizedBox()),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: rows,
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final QuickActionModel data;
  final VoidCallback? onTap;

  const _QuickActionItem({required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: AppContainer(
        opacity: 0.8,
        borderRadius: AppRadius.br24,
        showShadow: false,
        padding: EdgeInsets.zero,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.br24,
          child: Stack(
            children: [
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
              if (data.isComingSoon)
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
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: AppContainer(
                        width: 45,
                        height: 45,
                        color: context.colors.onSurfaceVariant,
                        opacity: 0.05,
                        showShadow: false,
                        padding: EdgeInsets.zero,
                        shape: BoxShape.circle,
                        child: Center(
                          child: HugeIcon(
                            icon: data.icon,
                            size: 22,
                            color: context.colors.onSurface,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      data.title.replaceAll(' ', '\n'),
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
      ),
    );
  }
}
