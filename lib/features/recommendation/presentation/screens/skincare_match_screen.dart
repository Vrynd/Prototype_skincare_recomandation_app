import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/themes/app_spacing.dart';
import 'package:skincare_recomendation/core/widgets/app_navigation.dart';
import 'package:skincare_recomendation/core/widgets/app_scafold.dart';
import 'package:skincare_recomendation/core/widgets/app_title_action.dart';
import 'package:skincare_recomendation/core/widgets/app_title_header.dart';
import 'package:skincare_recomendation/features/recommendation/presentation/widgets/last_recommendation_summary.dart';

class SkincareMatchScreen extends StatelessWidget {
  const SkincareMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScafold(
      statusBarIconBrightness: Brightness.light,
      showHandle: true,
      header: AppNavigation(title: 'Skincare Match'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        children: [
          const AppTitleHeader.form(
            title: 'Rekomendasi Skincare',
            spacing: 4,
            description:
                'Tinjau ringkasan rekomendasi terakhir Anda atau mulai analisis baru di bawah.',
          ),
          AppSpacing.v16,

          LastRecommendationSummary(),
          AppSpacing.v32,

          AppTitleAction.button(
            title: 'Formulir Rekomendasi',
            subtitle: 'Klik untuk memulai',
            onPressed: () {},
          ),
          AppSpacing.v16,
        ],
      ),
    );
  }
}
