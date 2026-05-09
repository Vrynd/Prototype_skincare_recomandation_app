import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/themes/app_spacing.dart';
import 'package:skincare_recomendation/core/widgets/app_scafold.dart';
import 'package:skincare_recomendation/core/widgets/app_location.dart';
import 'package:skincare_recomendation/features/home/presentation/widgets/summary.dart';
import 'package:skincare_recomendation/features/home/presentation/widgets/index_uv.dart';
import 'package:skincare_recomendation/features/home/models/uv_index_model.dart';
import 'package:skincare_recomendation/features/home/models/skin_summary_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScafold(
      statusBarIconBrightness: Brightness.light,
      header: const AppLocation(
        location: 'Kab Pati, Jawa Tengah',
        greeting: 'Selamat Pagi Sarah!',
        avatarUrl: 'https://i.pravatar.cc/150?img=47',
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          Summary(
            data: SkinSummaryModel(
              skinType: 'Normal',
              skinCondition: 'Berjerawat',
            ),
          ),
          AppSpacing.v8,

          IndexUV(
            data: UvIndexModel(
              currentUv: 8,
              forecastUv: [8, 5, 9, 4, 12, 6, 7],
            ),
          ),
        ],
      ),
    );
  }
}
