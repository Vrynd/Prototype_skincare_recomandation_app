import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_spacing.dart';
import 'package:skincare_recomendation/core/widgets/app_scafold.dart';
import 'package:skincare_recomendation/core/widgets/app_location.dart';
import 'package:skincare_recomendation/core/widgets/app_title_action.dart';
import 'package:skincare_recomendation/features/home/presentation/widgets/summary.dart';
import 'package:skincare_recomendation/features/home/presentation/widgets/index_uv.dart';
import 'package:skincare_recomendation/features/home/presentation/widgets/quick_action.dart';
import 'package:skincare_recomendation/features/home/models/quick_action_model.dart';
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
          AppSpacing.v32,

          const AppTitleAction.none(title: 'Aksi Cepat'),
          AppSpacing.v16,
          QuickAction(
            data: [
              QuickActionModel(
                title: 'My Skin',
                icon: HugeIcons.strokeRoundedFaceId,
              ),
              QuickActionModel(
                title: 'Skincare Match',
                icon: HugeIcons.strokeRoundedPuzzle,
              ),
              QuickActionModel(
                title: 'Daily Routine',
                icon: HugeIcons.strokeRoundedTaskDaily02,
              ),
              QuickActionModel(
                title: 'Skin Preference',
                icon: HugeIcons.strokeRoundedSlidersHorizontal,
              ),
            ],
          ),
          AppSpacing.v32,

          AppTitleAction.button(
            title: 'Rekomendasi Terbaru',
            subtitle: 'Minggu, 10 Mei',
            onPressed: () {},
          ),
          AppSpacing.v16,
        ],
      ),
    );
  }
}
