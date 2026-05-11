import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_radius.dart';
import 'package:skincare_recomendation/core/themes/app_spacing.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';
import 'package:skincare_recomendation/core/widgets/app_navigation.dart';
import 'package:skincare_recomendation/core/widgets/app_scafold.dart';

class LastRecommendationScreen extends StatelessWidget {
  final String title;

  const LastRecommendationScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppScafold(
      statusBarIconBrightness: Brightness.light,
      header: AppNavigation(
        title: title,
        actionIcon: HugeIcon(
          icon: HugeIcons.strokeRoundedDelete02,
          size: 24,
          color: context.colors.surface,
        ),
        onActionTap: () {},
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          AppContainer(
            height: 260,
            opacity: 0.8,
            showShadow: false,
            borderRadius: AppRadius.br24,
          ),
          AppSpacing.v8,

          AppContainer(
            height: 50,
            opacity: 0.8,
            showShadow: false,
            borderRadius: AppRadius.br24,
          ),
          AppSpacing.v8,

          AppContainer(
            height: 140,
            opacity: 0.8,
            showShadow: false,
            borderRadius: AppRadius.br24,
          ),
        ],
      ),
    );
  }
}
