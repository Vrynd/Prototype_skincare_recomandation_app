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
  final VoidCallback? onAvatarTap;
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
    this.onAvatarTap,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
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
      spacing: 12,
      children: [
        if (widget.actions != null) ...widget.actions!,
        if (widget.avatarUrl != null) _avatar,
      ],
    );
  }

  Widget get _avatar {
    return GestureDetector(
      onTap: widget.onAvatarTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 44,
            height: 44,
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
          ),
          if (widget.hasNotification)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: context.colors.error, // Warna merah notifikasi
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.colors.surfaceContainerLowest,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
