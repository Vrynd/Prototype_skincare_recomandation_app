import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';

class AppLocation extends StatelessWidget {
  final String greeting;
  final String location;
  final String avatarUrl;

  const AppLocation({
    super.key,
    required this.greeting,
    required this.location,
    required this.avatarUrl,
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
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colors.surface,
        border: Border.all(
          color: context.colors.surface.withValues(alpha: 0.8),
        ),
        image: DecorationImage(
          image: NetworkImage(avatarUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
