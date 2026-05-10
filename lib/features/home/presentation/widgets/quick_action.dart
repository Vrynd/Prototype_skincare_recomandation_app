import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_radius.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';
import 'package:skincare_recomendation/features/home/models/quick_action_model.dart';

class QuickAction extends StatelessWidget {
  final List<QuickActionModel> data;

  const QuickAction({super.key, required this.data});

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
            _QuickActionItem(data: data[i]),
            if (i + 1 < data.length)
              _QuickActionItem(data: data[i + 1])
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

  const _QuickActionItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: AppContainer(
        opacity: 0.8,
        borderRadius: AppRadius.br24,
        showShadow: false,
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            Positioned(
              bottom: -60,
              left: -30,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    center: Alignment.topLeft,
                    radius: 0.8,
                    colors: [
                      context.colors.primary.withValues(alpha: 0.15),
                      context.colors.primary.withValues(alpha: 0.0),
                    ],
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
                      width: 44,
                      height: 44,
                      color: context.colors.primaryContainer,
                      showShadow: false,
                      showBorder: false,
                      padding: EdgeInsets.zero,
                      shape: BoxShape.circle,
                      child: Center(
                        child: HugeIcon(
                          icon: data.icon,
                          size: 22,
                          color: context.colors.primary,
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
    );
  }
}
