import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/core.dart';

class AppContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final bool showBorder;
  final bool showShadow;
  final double opacity;
  final AlignmentGeometry? alignment;
  final BoxConstraints? constraints;
  final Clip clipBehavior;
  final Gradient? gradient;
  final BoxShape shape;
  final DecorationImage? image;

  const AppContainer({
    super.key,
    this.child,
    this.width = double.infinity,
    this.height,
    this.padding = const EdgeInsets.all(16),
    this.color,
    this.borderColor,
    this.borderRadius,
    this.showBorder = true,
    this.showShadow = true,
    this.opacity = 1.0,
    this.alignment,
    this.constraints,
    this.clipBehavior = Clip.antiAlias,
    this.gradient,
    this.shape = BoxShape.rectangle,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      alignment: alignment,
      constraints: constraints,
      clipBehavior: clipBehavior,
      decoration: _buildDecoration(context),
      child: child,
    );
  }

  BoxDecoration _buildDecoration(BuildContext context) {
    final backgroundColor = color ?? context.colors.surfaceContainerLowest;

    return BoxDecoration(
      color: gradient == null
          ? (color == Colors.transparent
                ? Colors.transparent
                : backgroundColor.withValues(alpha: opacity))
          : null,
      borderRadius: _radius,
      shape: shape,
      gradient: gradient,
      image: image,
      border: _border(context),
      boxShadow: _shadow(context),
    );
  }

  BorderRadius? get _radius {
    if (shape == BoxShape.circle) return null;
    return borderRadius ?? AppRadius.br16;
  }

  Border? _border(BuildContext context) {
    if (!showBorder) return null;
    return Border.all(
      color: borderColor ?? context.colors.surfaceContainerLowest,
      width: 1.3,
    );
  }

  List<BoxShadow>? _shadow(BuildContext context) {
    if (!showShadow) return null;
    return [
      BoxShadow(
        color: context.colors.shadow.withValues(alpha: 0.02),
        blurRadius: 20,
        offset: const Offset(0, 6),
      ),
    ];
  }
}
