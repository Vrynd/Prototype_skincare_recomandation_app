import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/features/auth/provider/remember_me_provider.dart';

class RememberRecovery extends StatelessWidget {
  const RememberRecovery({super.key});

  @override
  Widget build(BuildContext context) {
    final rememberMe = context.watch<RememberMeProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Remember Me
        GestureDetector(
          onTap: () => rememberMe.toggleRememberMe(),
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: rememberMe.isRememberMe 
                        ? context.colors.primary 
                        : context.colors.outline.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  color: rememberMe.isRememberMe 
                      ? context.colors.primary 
                      : Colors.transparent,
                ),
                child: rememberMe.isRememberMe
                    ? const Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(width: 10),
              Text(
                'Ingat saya',
                style: context.text.bodyMedium?.copyWith(
                  color: context.colors.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // Recovery Password
        GestureDetector(
          onTap: () {
            // Action lupa password
          },
          child: Text(
            'Lupa Kata Sandi?',
            style: context.text.bodyMedium?.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
