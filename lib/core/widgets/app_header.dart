import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/core.dart';


class AppHeader extends StatefulWidget implements PreferredSizeWidget {
  final bool isScrolled;
  final String title;
  final String? label;
  final String? avatarUrl;
  final List<Widget>? actions;
  final Widget? leading;
  final double height;

  const AppHeader({
    super.key,
    this.isScrolled = false,
    required this.title,
    this.label,
    this.avatarUrl,
    this.actions,
    this.leading,
    this.height = 100,
  });

  @override
  State<AppHeader> createState() => _AppHeaderState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _AppHeaderState extends State<AppHeader> {
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
    if (widget.leading == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: widget.leading!,
    );
  }

  Widget get _titleSection {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 2,
        children: [
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: context.text.bodyMedium?.copyWith(
                color: context.colors.outline,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          Text(
            widget.title,
            style: context.text.headlineMedium?.copyWith(
              color: context.colors.onSurface,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _actionsSection {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.actions != null) ...widget.actions!,
        if (widget.avatarUrl != null) ...[AppSpacing.h16, _avatar],
      ],
    );
  }

  Widget get _avatar {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colors.surface,
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(widget.avatarUrl!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
