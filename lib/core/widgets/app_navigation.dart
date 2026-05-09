import 'package:flutter/material.dart';

import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_glass.dart';

class AppNavigation extends StatefulWidget implements PreferredSizeWidget {
  final bool isScrolled;
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final double height;

  const AppNavigation({
    super.key,
    this.isScrolled = false,
    required this.title,
    this.actions,
    this.leading,
    this.height = 70,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  @override
  Widget build(BuildContext context) {
    return AppGlass(
      isScrolled: widget.isScrolled,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_leading, _titleSection, _actionsSection],
      ),
    );
  }

  Widget get _leading {
    if (widget.leading == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: widget.leading,
    );
  }

  Widget get _titleSection {
    return Expanded(
      child: Text(
        widget.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.text.headlineSmall?.copyWith(
          color: context.colors.surface,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget get _actionsSection {
    if (widget.actions == null) return const SizedBox.shrink();
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: widget.actions!,
    );
  }
}
