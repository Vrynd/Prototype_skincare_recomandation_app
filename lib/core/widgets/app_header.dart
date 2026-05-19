import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_avatar.dart';
import 'package:skincare_recomendation/core/widgets/app_toast.dart';

class AppHeader extends StatelessWidget {
  final String userName;
  final String? avatarUrl;
  final VoidCallback? onNotificationTap;

  const AppHeader({
    super.key,
    required this.userName,
    this.avatarUrl,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Glowly',
              style: context.text.headlineLarge?.copyWith(
                color: context.colors.surface,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            _actionGroup(context),
          ],
        ),
      ),
    );
  }

  Widget _actionGroup(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: context.colors.surface.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: context.colors.surface.withValues(alpha: 0.20),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 1,
        children: [
          _actionButton(
            context,
            icon: HugeIcons.strokeRoundedNotification01,
            onTap: onNotificationTap ?? () {
              AppToast.showInfo(context, 'Tidak ada notifikasi baru');
            },
          ),
          _avatar(context),
        ],
      ),
    );
  }

  Widget _actionButton(BuildContext context, {required dynamic icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colors.surface.withValues(alpha: 0.08),
        ),
        child: Center(
          child: HugeIcon(
            icon: icon,
            color: context.colors.surface,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _avatar(BuildContext context) {
    return AppAvatar(
      imageUrl: avatarUrl,
      name: userName,
      size: 42,
      borderWidth: 0,
      borderColor: Colors.transparent,
      isGlass: true,
    );
  }
}
