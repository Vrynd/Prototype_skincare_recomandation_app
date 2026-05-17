import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_button.dart';

enum FooterStyle { text, button }

class AppTitleFooter extends StatelessWidget {
  final FooterStyle style;
  final String title;
  final String actionTitle;
  final VoidCallback? onTap;
  final bool isLoading;

  // Text variant (default constructor)
  const AppTitleFooter({
    super.key,
    required this.title,
    required this.actionTitle,
    required this.onTap,
  }) : style = FooterStyle.text,
       isLoading = false;

  // Button variant (named constructor)
  const AppTitleFooter.button({
    super.key,
    required this.title,
    this.onTap,
    this.isLoading = false,
  }) : style = FooterStyle.button,
       actionTitle = '';

  @override
  Widget build(BuildContext context) {
    if (style == FooterStyle.button) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 60),
        child: AppButton(
          title: title,
          onTap: onTap,
          isLoading: isLoading,
          variant: ButtonVariant.primary,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: context.text.bodyMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(8),
              splashColor: context.colors.primary.withValues(alpha: 0.1),
              highlightColor: context.colors.primary.withValues(alpha: 0.05),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Text(
                  actionTitle,
                  style: context.text.bodyMedium?.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
