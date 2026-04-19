import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_radius.dart';
import 'package:skincare_recomendation/core/themes/app_spacing.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';

enum ActionStyle { button, text, none }

class AppTitleAction extends StatelessWidget {
  final ActionStyle style;

  final String title;
  final String? subtitle;
  final String actionText;
  final Widget? actionIcon;
  final VoidCallback? onPressed;

  const AppTitleAction({
    super.key,
    required this.title,
    this.subtitle,
    this.actionText = 'See All',
    this.actionIcon,
    this.style = ActionStyle.none,
    this.onPressed,
  });

  const AppTitleAction.button({
    super.key,
    required this.title,
    this.subtitle,
    this.actionText = '',
    this.actionIcon,
    this.onPressed,
  }) : style = ActionStyle.button;

  const AppTitleAction.text({
    super.key,
    required this.title,
    this.subtitle,
    this.actionText = 'See All',
    this.onPressed,
  }): style = ActionStyle.text,
      actionIcon = null;

  const AppTitleAction.none({
    super.key,
    required this.title,
    this.subtitle,
  }): style = ActionStyle.none,
      actionText = '',
      actionIcon = null,
      onPressed = null;

  @override
  Widget build(BuildContext context) {
    final actionWidget = _buildAction(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.text.titleLarge?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              if (subtitle != null && subtitle!.isNotEmpty) ...[
                Text(
                  subtitle!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.bodyMedium?.copyWith(
                    color: context.colors.outline,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (actionWidget != null) ...[
          AppSpacing.h12,
          actionWidget,
        ],
      ],
    );
  }

  Widget? _buildAction(BuildContext context) {
    switch (style) {
      case ActionStyle.button:
        final hasIcon = actionIcon != null;
        final hasText = actionText.isNotEmpty;

        if (!hasIcon && !hasText) {
          return ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: const Size(38, 38),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              backgroundColor: context.colors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.br24
              ),
            ),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedArrowRight01,
              color: context.colors.onPrimary,
              size: 20,
            ),
          );
        }

        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            minimumSize: const Size(38, 38),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            backgroundColor: context.colors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.br24
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hasIcon) actionIcon!,
              if (hasIcon && hasText) const SizedBox(width: 6),
              if (hasText)
                Text(
                  actionText,
                  style: context.text.labelLarge?.copyWith(
                    color: context.colors.onPrimary,
                  ),
                ),
            ],
          ),
        );

      case ActionStyle.text:
        return TextButton(
          onPressed: onPressed,
          child: Text(
            actionText,
            style: context.text.bodyMedium?.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        );

      case ActionStyle.none:
        return null;
    }
  }
}
