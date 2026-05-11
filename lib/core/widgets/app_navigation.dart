import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';

class AppNavigation extends StatelessWidget implements PreferredSizeWidget {
  final bool isScrolled;
  final String title;
  final Widget? actionIcon;
  final VoidCallback? onActionTap;
  final Widget? leading;
  final double height;

  const AppNavigation({
    super.key,
    this.isScrolled = false,
    required this.title,
    this.actionIcon,
    this.onActionTap,
    this.leading,
    this.height = 70,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final resolvedLeading = _buildLeading(context);
    final hasLeading = resolvedLeading != null;

    return AppBar(
      toolbarHeight: height,
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      leadingWidth: hasLeading ? 60 : 0,
      leading: resolvedLeading,
      title: _buildTitle(context, hasLeading),
      actions: _buildActions(context),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    Widget? activeLeading = leading;
    final canPop = Navigator.of(context).canPop();

    if (activeLeading == null && canPop) {
      activeLeading = _buildCircularButton(
        context: context,
        onTap: () => context.pop(),
        icon: HugeIcon(
          icon: HugeIcons.strokeRoundedArrowLeft02,
          color: context.colors.surface,
          size: 24,
        ),
      );
    }

    if (activeLeading != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Center(child: activeLeading),
      );
    }

    return null;
  }

  Widget _buildTitle(BuildContext context, bool hasLeading) {
    return Padding(
      padding: hasLeading ? EdgeInsets.zero : const EdgeInsets.only(left: 16.0),
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.text.headlineSmall?.copyWith(
          color: context.colors.surface,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  List<Widget>? _buildActions(BuildContext context) {
    if (actionIcon == null || onActionTap == null) return null;

    return [
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Center(
          child: _buildCircularButton(
            context: context,
            onTap: onActionTap!,
            icon: actionIcon!,
          ),
        ),
      ),
    ];
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
        width: 44,
        height: 44,
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
