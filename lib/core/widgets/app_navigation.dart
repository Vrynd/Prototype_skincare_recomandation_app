import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';

class AppNavigation extends StatelessWidget {
  final bool isScrolled;
  final String title;
  final String? subtitle;
  final Widget? actionIcon;
  final VoidCallback? onActionTap;
  final Widget? leading;
  final Widget? trailing;
  final bool showBackButton;
  final double? height;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final bool centerTitle;
  final Color? iconColor;

  const AppNavigation({
    super.key,
    this.isScrolled = false,
    required this.title,
    this.subtitle,
    this.actionIcon,
    this.onActionTap,
    this.leading,
    this.trailing,
    this.showBackButton = true,
    this.height,
    this.backgroundColor,
    this.padding,
    this.titleStyle,
    this.subtitleStyle,
    this.centerTitle = false,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedLeading = _buildLeading(context);
    final resolvedTrailing = _buildTrailing(context);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        boxShadow: isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
      ),
      child: SafeArea(
        bottom: false,
        child: Container(
          height: height,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (resolvedLeading != null) ...[
                resolvedLeading,
                const SizedBox(width: 12),
              ],
              Expanded(
                child: _buildTitle(context),
              ),
              if (resolvedTrailing != null) ...[
                const SizedBox(width: 12),
                resolvedTrailing,
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;

    final canPop = Navigator.of(context).canPop();
    if (showBackButton && canPop) {
      return _buildCircularButton(
        context: context,
        onTap: () => context.pop(),
        icon: HugeIcon(
          icon: HugeIcons.strokeRoundedArrowLeft02,
          color: iconColor ?? context.colors.surface,
          size: 24,
        ),
      );
    }

    return null;
  }

  Widget? _buildTrailing(BuildContext context) {
    if (trailing != null) return trailing;

    if (actionIcon != null && onActionTap != null) {
      return _buildCircularButton(
        context: context,
        onTap: onActionTap!,
        icon: actionIcon!,
      );
    }

    return null;
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: centerTitle ? TextAlign.center : TextAlign.start,
          style: titleStyle ??
              context.text.headlineSmall?.copyWith(
                color: context.colors.surface,
                fontWeight: FontWeight.bold,
              ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: centerTitle ? TextAlign.center : TextAlign.start,
            style: subtitleStyle ??
                context.text.bodySmall?.copyWith(
                  color: context.colors.surface.withValues(alpha: 0.7),
                ),
          ),
        ],
      ],
    );
  }

  Widget _buildCircularButton({
    required BuildContext context,
    required VoidCallback onTap,
    required Widget icon,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: AppContainer(
        width: 46,
        height: 46,
        shape: BoxShape.circle,
        padding: EdgeInsets.zero,
        opacity: 0.2,
        showShadow: false,
        borderColor: context.colors.surface.withValues(alpha: 0.2),
        alignment: Alignment.center,
        child: icon,
      ),
    );
  }
}
