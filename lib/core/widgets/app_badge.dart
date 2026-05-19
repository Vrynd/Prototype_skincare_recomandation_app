import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/themes/app_radius.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';

enum AppBadgeVariant { filled, tonal, outlined, ghost }

enum AppBadgeSize { small, medium, large }

class AppBadge extends StatelessWidget {
  final String label;
  final Color? color;
  final IconData? icon;
  final AppBadgeVariant variant;
  final AppBadgeSize size;

  const AppBadge({
    super.key,
    required this.label,
    this.color,
    this.icon,
    this.variant = AppBadgeVariant.tonal,
    this.size = AppBadgeSize.medium,
  });

  const AppBadge.filled({
    super.key,
    required this.label,
    this.color,
    this.icon,
    this.size = AppBadgeSize.medium,
  }) : variant = AppBadgeVariant.filled;

  const AppBadge.tonal({
    super.key,
    required this.label,
    this.color,
    this.icon,
    this.size = AppBadgeSize.medium,
  }) : variant = AppBadgeVariant.tonal;

  const AppBadge.outlined({
    super.key,
    required this.label,
    this.color,
    this.icon,
    this.size = AppBadgeSize.medium,
  }) : variant = AppBadgeVariant.outlined;

  const AppBadge.ghost({
    super.key,
    required this.label,
    this.color,
    this.icon,
    this.size = AppBadgeSize.medium,
  }) : variant = AppBadgeVariant.ghost;

  @override
  Widget build(BuildContext context) {
    final activeColor = color ?? context.colors.primary;

    final double horizontalPadding;
    final double verticalPadding;
    final TextStyle? textStyle;
    final double iconSize;

    switch (size) {
      case AppBadgeSize.small:
        horizontalPadding = 8;
        verticalPadding = 2;
        textStyle = context.text.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
        );
        iconSize = 10;
        break;
      case AppBadgeSize.medium:
        horizontalPadding = 12;
        verticalPadding = 4;
        textStyle = context.text.bodySmall?.copyWith(
          fontWeight: FontWeight.w600,
        );
        iconSize = 14;
        break;
      case AppBadgeSize.large:
        horizontalPadding = 16;
        verticalPadding = 6;
        textStyle = context.text.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        );
        iconSize = 18;
        break;
    }

    Color backgroundColor;
    double opacity;
    bool showBorder;
    Color? borderColor;
    Color textColor;

    switch (variant) {
      case AppBadgeVariant.filled:
        backgroundColor = activeColor;
        opacity = 1.0;
        showBorder = false;
        textColor = context.colors.onPrimary;
        break;
      case AppBadgeVariant.tonal:
        backgroundColor = activeColor;
        opacity = 0.1;
        showBorder = true;
        borderColor = activeColor.withValues(alpha: 0.2);
        textColor = activeColor;
        break;
      case AppBadgeVariant.outlined:
        backgroundColor = Colors.transparent;
        opacity = 0.0;
        showBorder = true;
        borderColor = activeColor.withValues(alpha: 0.4);
        textColor = activeColor;
        break;
      case AppBadgeVariant.ghost:
        backgroundColor = Colors.transparent;
        opacity = 0.0;
        showBorder = false;
        textColor = activeColor;
        break;
    }

    return AppContainer(
      width: null,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      color: backgroundColor,
      opacity: opacity,
      borderRadius: AppRadius.br16,
      borderColor: borderColor,
      showBorder: showBorder,
      showShadow: false,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          if (icon != null) Icon(icon, size: iconSize, color: textColor),
          Text(label, style: textStyle?.copyWith(color: textColor)),
        ],
      ),
    );
  }
}
