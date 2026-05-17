import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';

enum HeaderStyle { normal, form }

class AppTitleHeader extends StatelessWidget {
  final HeaderStyle style;
  final String title;
  final String description;
  final double spacing;

  const AppTitleHeader({
    super.key,
    required this.title,
    required this.description,
    this.spacing = 16.0,
  }) : style = HeaderStyle.normal;

  const AppTitleHeader.form({
    super.key,
    required this.title,
    required this.description,
    this.spacing = 16.0,
  }) : style = HeaderStyle.form;

  @override
  Widget build(BuildContext context) {
    final titleStyle = style == HeaderStyle.form
        ? context.text.headlineLarge?.copyWith(
            color: context.colors.onSurface,
          )
        : context.text.displaySmall?.copyWith(
            fontWeight: FontWeight.w600,
          );

    final descriptionStyle = style == HeaderStyle.form
        ? context.text.bodyLarge?.copyWith(
            color: context.colors.outline,
          )
        : context.text.bodyLarge?.copyWith(
            color: context.colors.onSurfaceVariant,
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spacing,
      children: [
        Text(
          title,
          style: titleStyle,
        ),
        Text(
          description,
          style: descriptionStyle,
        ),
      ],
    );
  }
}
