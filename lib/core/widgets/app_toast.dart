import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_colors.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';
import 'package:skincare_recomendation/core/widgets/app_toast_overlay.dart';

enum AppToastVariant { success, error, warning, info }

class AppToast extends StatelessWidget {
  final String message;
  final AppToastVariant variant;

  const AppToast({super.key, required this.message, required this.variant});

  static OverlayEntry? _currentOverlay;

  static void showSuccess(BuildContext context, String message) {
    _show(context, message, AppToastVariant.success);
  }

  static void showError(BuildContext context, String message) {
    _show(context, message, AppToastVariant.error);
  }

  static void showWarning(BuildContext context, String message) {
    _show(context, message, AppToastVariant.warning);
  }

  static void showInfo(BuildContext context, String message) {
    _show(context, message, AppToastVariant.info);
  }

  static void _show(
    BuildContext context,
    String message,
    AppToastVariant variant,
  ) {
    if (_currentOverlay != null) {
      _currentOverlay!.remove();
      _currentOverlay = null;
    }

    final overlay = Overlay.of(context);

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => AppToastOverlay(
        message: message,
        variant: variant,
        onDismiss: () {
          if (_currentOverlay == entry) {
            entry.remove();
            _currentOverlay = null;
          }
        },
      ),
    );

    _currentOverlay = entry;
    overlay.insert(entry);
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = _getColor(context);
    final themeIcon = _getIcon();
    final textColor = _getTextColor(context);
    final iconBgColor = _getIconBgColor(context);
    final iconColor = _getIconColor(context);

    return AppContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      color: themeColor,
      showBorder: false,
      showShadow: true,
      customShadows: [
        BoxShadow(
          color: themeColor.withValues(alpha: 0.3),
          blurRadius: 16,
          spreadRadius: 2,
          offset: const Offset(0, 6),
        ),
      ],
      child: Row(
        spacing: 14,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppContainer(
            width: 36,
            height: 36,
            padding: EdgeInsets.zero,
            color: iconBgColor,
            shape: BoxShape.circle,
            showBorder: false,
            showShadow: false,
            child: Center(
              child: HugeIcon(icon: themeIcon, color: iconColor, size: 20),
            ),
          ),
          Expanded(
            child: Text(
              message,
              style: context.text.bodyMedium?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(BuildContext context) {
    switch (variant) {
      case AppToastVariant.success:
        return AppColors.success;
      case AppToastVariant.error:
        return AppColors.accentRed;
      case AppToastVariant.warning:
        return AppColors.warning;
      case AppToastVariant.info:
        return AppColors.info;
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (variant) {
      case AppToastVariant.warning:
        return context.colors.onSurface;
      default:
        return context.colors.surface;
    }
  }

  Color _getIconBgColor(BuildContext context) {
    switch (variant) {
      case AppToastVariant.warning:
        return context.colors.onSurface;
      default:
        return context.colors.surface;
    }
  }

  Color _getIconColor(BuildContext context) {
    switch (variant) {
      case AppToastVariant.warning:
        return AppColors.warning;
      case AppToastVariant.success:
        return AppColors.success;
      case AppToastVariant.error:
        return AppColors.accentRed;
      case AppToastVariant.info:
        return AppColors.info;
    }
  }

  List<List<dynamic>> _getIcon() {
    switch (variant) {
      case AppToastVariant.success:
        return HugeIcons.strokeRoundedTickDouble01;
      case AppToastVariant.error:
        return HugeIcons.strokeRoundedAlertCircle;
      case AppToastVariant.warning:
        return HugeIcons.strokeRoundedAlertCircle;
      case AppToastVariant.info:
        return HugeIcons.strokeRoundedInformationCircle;
    }
  }
}
