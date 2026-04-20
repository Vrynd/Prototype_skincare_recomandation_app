import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/core.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget {
  final bool isScrolled;
  final String title;
  final String? label;
  final String? avatarUrl;
  final List<Widget>? actions;
  final Widget? leading;
  final double height;
  final VoidCallback? onNotificationTap;
  final bool hasNotification;

  const AppHeader({
    super.key,
    this.isScrolled = false,
    required this.title,
    this.label,
    this.avatarUrl,
    this.actions,
    this.leading,
    this.height = 100,
    this.onNotificationTap,
    this.hasNotification = false,
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
    if (widget.leading == null && widget.avatarUrl == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: widget.leading ?? _avatar,
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
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: context.colors.surfaceContainerLowest,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: widget.onNotificationTap,
            icon: HugeIcon(
              icon: widget.hasNotification
                  ? HugeIcons.strokeRoundedNotification02
                  : HugeIcons.strokeRoundedNotification01,
              color: context.colors.onSurface,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget get _avatar {
    return Container(
      width: 46,
      height: 46,
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
