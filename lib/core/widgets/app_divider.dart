import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';

enum DividerStyle { dashed, solid }

class AppDivider extends StatelessWidget {
  final DividerStyle style;
  final Axis axis;
  final double thickness;
  final double width;
  final double space;
  final Color? color;
  final double indent;
  final double endIndent;

  const AppDivider({
    super.key,
    this.style = DividerStyle.dashed,
    this.axis = Axis.horizontal,
    this.thickness = 0.5,
    this.width = 4.0,
    this.space = 4.0,
    this.color,
    this.indent = 0.0,
    this.endIndent = 0.0,
  });

  const AppDivider.dashed({
    super.key,
    this.axis = Axis.horizontal,
    this.thickness = .5,
    this.width = 4.0,
    this.space = 4.0,
    this.color,
    this.indent = 0.0,
    this.endIndent = 0.0,
  }) : style = DividerStyle.dashed;

  const AppDivider.solid({
    super.key,
    this.axis = Axis.horizontal,
    this.thickness = .5,
    this.color,
    this.indent = 0.0,
    this.endIndent = 0.0,
  }) : style = DividerStyle.solid,
       width = 0.0,
       space = 0.0;

  @override
  Widget build(BuildContext context) {
    final dividerColor = color ?? context.colors.outlineVariant;

    if (style == DividerStyle.solid) {
      return _buildSolidDivider(dividerColor);
    }
    return _buildDashedDivider(dividerColor);
  }

  Widget _buildSolidDivider(Color dividerColor) {
    final isHorizontal = axis == Axis.horizontal;

    return Padding(
      padding: isHorizontal
          ? EdgeInsets.only(left: indent, right: endIndent)
          : EdgeInsets.only(top: indent, bottom: endIndent),
      child: Container(
        height: isHorizontal ? thickness : double.infinity,
        width: isHorizontal ? double.infinity : thickness,
        color: dividerColor,
      ),
    );
  }

  Widget _buildDashedDivider(Color dividerColor) {
    final isHorizontal = axis == Axis.horizontal;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate available length based on axis
        final availableLength = isHorizontal
            ? constraints.maxWidth - indent - endIndent
            : constraints.maxHeight - indent - endIndent;

        // Calculate dash count
        final dashCount = (availableLength / (width + space)).floor();

        return Padding(
          padding: isHorizontal
              ? EdgeInsets.only(left: indent, right: endIndent)
              : EdgeInsets.only(top: indent, bottom: endIndent),
          child: _renderDashes(dashCount, dividerColor),
        );
      },
    );
  }

  Widget _renderDashes(int count, Color dividerColor) {
    final isHorizontal = axis == Axis.horizontal;

    final List<Widget> dashes = List.generate(count, (_) {
      return SizedBox(
        width: isHorizontal ? width : thickness,
        height: isHorizontal ? thickness : width,
        child: DecoratedBox(decoration: BoxDecoration(color: dividerColor)),
      );
    });

    if (isHorizontal) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: dashes,
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: dashes,
      );
    }
  }
}
