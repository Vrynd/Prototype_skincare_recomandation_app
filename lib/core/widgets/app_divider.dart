import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';

enum DividerStyle { dashed, solid }

class AppDivider extends StatelessWidget {
  final DividerStyle style;

  final double thickness;
  final double width;
  final double space;
  final Color? color;
  final double indent;
  final double endIndent;

  const AppDivider({
    super.key,
    this.style = DividerStyle.dashed,
    this.thickness = 0.5,
    this.width = 4.0,
    this.space = 4.0,
    this.color,
    this.indent = 0.0,
    this.endIndent = 0.0,
  });

  const AppDivider.dashed({
    super.key,
    this.thickness = .5,
    this.width = 4.0,
    this.space = 4.0,
    this.color,
    this.indent = 0.0,
    this.endIndent = 0.0,
  }): style = DividerStyle.dashed;

  const AppDivider.solid({
    super.key,
    this.thickness = .5,
    this.color,
    this.indent = 0.0,
    this.endIndent = 0.0,
  }): style = DividerStyle.solid,
      width = 0.0,
      space = 0.0;

  @override
  Widget build(BuildContext context) {
    final dividerColor = color ?? context.colors.outlineVariant;

    if (style == DividerStyle.solid) {
      return Padding(
        padding: EdgeInsets.only(left: indent, right: endIndent),
        child: Container(
          height: thickness,
          width: double.infinity,
          color: dividerColor,
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth - indent - endIndent;
        final dashCount = (availableWidth / (width + space)).floor();

        return Padding(
          padding: EdgeInsets.only(left: indent, right: endIndent),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: width,
                height: thickness,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: dividerColor),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
