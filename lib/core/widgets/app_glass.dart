import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';

class AppGlass extends StatelessWidget {
  final Widget child;
  final bool isScrolled;

  const AppGlass({
    super.key,
    required this.child,
    required this.isScrolled,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: isScrolled ? 10 : 0,
            sigmaY: isScrolled ? 10 : 0,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: isScrolled
                ? context.colors.surfaceContainerLowest.withValues(alpha: 0.6)
                : context.colors.surfaceContainerLowest.withValues(alpha: 0.0),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
