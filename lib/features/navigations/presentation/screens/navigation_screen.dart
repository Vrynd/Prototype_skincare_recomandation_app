import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';

class NavigationScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const NavigationScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: SalomonBottomBar(
        margin: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        backgroundColor: context.colors.surfaceContainerLowest,
        currentIndex: navigationShell.currentIndex,
        onTap: (i) => navigationShell.goBranch(i),
        items: [
          SalomonBottomBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedHome01,
              size: 25,
              color: context.colors.onSurfaceVariant.withValues(alpha: .8),
            ),
            activeIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedHome01,
              size: 25,
              color: context.colors.primary,
            ),
            title: Text(
              "Beranda",
              style: context.text.bodyLarge?.copyWith(
                color: context.colors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            selectedColor: context.colors.primary,
            unselectedColor: context.colors.secondary,
          ),
          SalomonBottomBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedAnalytics02,
              size: 25,
              color: context.colors.onSurfaceVariant.withValues(alpha: .8),
            ),
            activeIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedAnalytics02,
              size: 25,
              color: context.colors.primary,
            ),
            title: Text(
              "Insight",
              style: context.text.bodyLarge?.copyWith(
                color: context.colors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            selectedColor: context.colors.primary,
            unselectedColor: context.colors.secondary,
          ),
          SalomonBottomBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedDateTime,
              size: 25,
              color: context.colors.onSurfaceVariant.withValues(alpha: .8),
            ),
            activeIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedDateTime,
              size: 25,
              color: context.colors.primary,
            ),
            title: Text(
              "Riwayat",
              style: context.text.bodyLarge?.copyWith(
                color: context.colors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            selectedColor: context.colors.primary,
            unselectedColor: context.colors.secondary,
          ),
          SalomonBottomBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedAccountSetting03,
              size: 25,
              color: context.colors.onSurfaceVariant.withValues(alpha: .8),
            ),
            activeIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedAccountSetting03,
              size: 25,
              color: context.colors.primary,
            ),
            title: Text(
              "Akun Saya",
              style: context.text.bodyLarge?.copyWith(
                color: context.colors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            selectedColor: context.colors.primary,
            unselectedColor: context.colors.secondary,
          ),
        ],
      ),
    );
  }
}
