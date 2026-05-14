import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_radius.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';
import 'package:skincare_recomendation/core/widgets/app_divider.dart';

class AccountProfile extends StatelessWidget {
  final String name;
  final String email;
  final String avatarUrl;
  final String accountStatus;
  final bool isOnline;
  final VoidCallback? onTap;

  const AccountProfile({
    super.key,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.accountStatus,
    this.isOnline = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: AppContainer(
        borderRadius: AppRadius.br24,
        opacity: 0.8,
        showShadow: false,
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Row(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: Image.network(avatarUrl).image,
                      ),
                      if (isOnline)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: context.colors.surfaceContainerLowest,
                                width: 2.5,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4,
                      children: [
                        Text(
                          name,
                          style: context.text.titleLarge?.copyWith(
                            color: context.colors.onSurface,
                          ),
                        ),
                        Text(
                          email,
                          style: context.text.bodyLarge?.copyWith(
                            color: context.colors.onSurfaceVariant
                          ),
                        ),
                      ],
                    ),
                  ),
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedArrowUpRight01,
                    color: context.colors.onSurfaceVariant.withValues(alpha: 0.6),
                    size: 20,
                  ),
                ],
              ),
            ),
            const AppDivider.dashed(indent: 0),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status Akun',
                    style: context.text.bodyMedium?.copyWith(
                      color: context.colors.onSurfaceVariant.withValues(
                        alpha: 0.8,
                      ),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.secondaryContainer.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      accountStatus.toUpperCase(),
                      style: context.text.labelSmall?.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
