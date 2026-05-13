import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_spacing.dart';
import 'package:skincare_recomendation/core/widgets/app_button.dart';

/// Widget untuk tombol login sosial (Google & Apple)
class SocialButton extends StatelessWidget {
  final VoidCallback? onGoogleTap;
  final VoidCallback? onAppleTap;

  const SocialButton({super.key, this.onGoogleTap, this.onAppleTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: AppButton.outline(
            icon: HugeIcons.strokeRoundedGoogle,
            title: 'Google',
            onTap: onGoogleTap,
            iconColor: Colors.redAccent,
          ),
        ),
        AppSpacing.h16,
        Expanded(
          child: AppButton.outline(
            icon: HugeIcons.strokeRoundedApple,
            title: 'Apple',
            onTap: onAppleTap,
          ),
        ),
      ],
    );
  }
}