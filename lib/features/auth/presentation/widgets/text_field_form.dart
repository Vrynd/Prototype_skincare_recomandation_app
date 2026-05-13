import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:skincare_recomendation/core/themes/app_radius.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/features/auth/provider/password_visibility_provider.dart';

class TextFieldForm extends StatelessWidget {
  final String hintText;
  final dynamic icon;
  final bool isPasswordField;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const TextFieldForm({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPasswordField = false,
    this.keyboardType,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    // Menggunakan PasswordVisibilityProvider khusus jika isPasswordField true
    final visibilityProvider = isPasswordField 
        ? context.watch<PasswordVisibilityProvider>() 
        : null;

    return Container(
      decoration: BoxDecoration(
        color: context.colors.onSurfaceVariant.withValues(alpha: 0.06),
        borderRadius: AppRadius.br16,
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: isPasswordField ? visibilityProvider!.isObscured : false,
        keyboardType: keyboardType,
        style: context.text.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: context.text.bodyLarge?.copyWith(
            color: context.colors.outline.withValues(alpha: 0.7),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: HugeIcon(
              icon: icon,
              color: context.colors.onSurface,
              size: 22,
            ),
          ),
          suffixIcon: isPasswordField
              ? Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    onPressed: () => visibilityProvider.toggleVisibility(),
                    icon: HugeIcon(
                      icon: visibilityProvider!.isObscured
                          ? HugeIcons.strokeRoundedViewOffSlash
                          : HugeIcons.strokeRoundedView,
                      color: context.colors.outline,
                      size: 20,
                    ),
                  ),
                )
              : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
