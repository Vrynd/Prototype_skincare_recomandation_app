import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_avatar.dart';

class AppLocation extends StatelessWidget {
  final String greeting;
  final String location;
  final String userName;
  final String? avatarUrl;

  const AppLocation({
    super.key,
    required this.greeting,
    required this.location,
    required this.userName,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: [
                  Text(
                    greeting,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.text.bodyLarge?.copyWith(
                      color: context.colors.surface.withValues(alpha: .8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.text.headlineLarge?.copyWith(
                      color: context.colors.surface,
                    ),
                  ),
                ],
              ),
            ),
            _avatar(context),
          ],
        ),
      ),
    );
  }

  Widget _avatar(BuildContext context) {
    return AppAvatar(
      imageUrl: avatarUrl,
      name: userName,
      size: 48,
      borderWidth: 1.1,
    );
  }
}
