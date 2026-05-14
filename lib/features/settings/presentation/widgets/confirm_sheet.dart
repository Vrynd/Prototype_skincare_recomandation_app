import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_bottom_sheet.dart';
import 'package:skincare_recomendation/core/widgets/app_button.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';

class ConfirmSheet extends StatelessWidget {
  final String title;
  final String description;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final bool isDanger;
  final dynamic icon;
  final Color? iconColor;

  const ConfirmSheet({
    super.key,
    required this.title,
    required this.description,
    required this.confirmText,
    this.cancelText = 'Batal',
    required this.onConfirm,
    this.onCancel,
    this.isDanger = false,
    this.icon,
    this.iconColor,
  });

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String description,
    required String confirmText,
    String cancelText = 'Batal',
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    bool isDanger = false,
    dynamic icon,
    Color? iconColor,
  }) {
    return AppBottomSheet.show(
      context: context,
      child: ConfirmSheet(
        title: title,
        description: description,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        isDanger: isDanger,
        icon: icon,
        iconColor: iconColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 24,
      children: [
        if (icon != null)
          _ConfirmIllustration(
            icon: icon,
            color: iconColor ??
                (isDanger ? context.colors.error : context.colors.primary),
          ),
        _ConfirmHeader(title: title, description: description),
        _ConfirmActions(
          confirmText: confirmText,
          cancelText: cancelText,
          onConfirm: onConfirm,
          onCancel: onCancel,
          isDanger: isDanger,
        ),
      ],
    );
  }
}

class _ConfirmHeader extends StatelessWidget {
  final String title;
  final String description;

  const _ConfirmHeader({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: [
        Text(
          title,
          style: context.text.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: context.colors.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          description,
          style: context.text.bodyLarge?.copyWith(
            color: context.colors.onSurface.withValues(alpha: 0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ConfirmIllustration extends StatelessWidget {
  final dynamic icon;
  final Color color;

  const _ConfirmIllustration({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppContainer(
        width: 80,
        height: 80,
        padding: EdgeInsets.zero,
        color: color,
        opacity: 0.04,
        shape: BoxShape.circle,
        showBorder: false,
        showShadow: true,
        customShadows: [
          BoxShadow(
            color: color.withValues(alpha: 0.05),
            blurRadius: 25,
            spreadRadius: 2,
          ),
        ],
        child: Center(
          child: AppContainer(
            width: 65,
            height: 65,
            padding: EdgeInsets.zero,
            color: color,
            opacity: 0.15,
            shape: BoxShape.circle,
            showBorder: false,
            showShadow: true,
            customShadows: [
              BoxShadow(
                color: color.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
            child: Center(child: _buildIcon()),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (icon is List<List<dynamic>>) {
      return HugeIcon(icon: icon, color: color, size: 32);
    } else if (icon is IconData) {
      return Icon(icon, color: color, size: 32);
    }
    return const SizedBox.shrink();
  }
}

class _ConfirmActions extends StatelessWidget {
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final bool isDanger;

  const _ConfirmActions({
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    this.onCancel,
    required this.isDanger,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 16,
      children: [
        Expanded(
          child: AppButton.outline(
            title: cancelText,
            onTap: () {
              Navigator.pop(context);
              onCancel?.call();
            },
          ),
        ),
        Expanded(
          child: isDanger
              ? AppButton.danger(
                  title: confirmText,
                  onTap: () {
                    Navigator.pop(context);
                    onConfirm();
                  },
                )
              : AppButton.primary(
                  title: confirmText,
                  onTap: () {
                    Navigator.pop(context);
                    onConfirm();
                  },
                ),
        ),
      ],
    );
  }
}
