import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skincare_recomendation/core/themes/app_spacing.dart';
import 'package:skincare_recomendation/core/widgets/app_scafold.dart';
import 'package:skincare_recomendation/core/widgets/app_header.dart';
import 'package:skincare_recomendation/core/widgets/app_title_action.dart';
import 'package:skincare_recomendation/core/widgets/app_title_header.dart';
import 'package:skincare_recomendation/features/home/data/uv_index_data.dart';
import 'package:skincare_recomendation/features/home/models/uv_index_model.dart';
import 'package:skincare_recomendation/features/home/presentation/widgets/recommendation_summary.dart';
import 'package:skincare_recomendation/features/home/presentation/widgets/uv_index.dart';
import 'package:skincare_recomendation/features/home/presentation/widgets/quick_action.dart';

import 'package:skincare_recomendation/features/auth/provider/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  UvIndexModel get _indexs => UvIndexData.uvIndex;

  void _onQuickTap(BuildContext context, String title) {
    switch (title) {
      case 'Kenali Kulitmu':
        // context.pushNamed('skin-condition');
        break;
      case 'Dapatkan Rekomendasi':
        context.pushNamed('skincare-match');
        break;
      default:
        debugPrint('Aksi cepat "$title" diklik');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().userProfile;
    final fullName = user?.namaLengkap ?? 'Pengguna';
    final firstName = fullName.split(' ').first;
    final avatarUrl = user?.fotoProfile;

    return AppScafold(
      statusBarIconBrightness: Brightness.light,
      showHandle: true,
      header: AppHeader(userName: fullName, avatarUrl: avatarUrl),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        children: [
          AppTitleHeader.form(
            title: 'Halo, $firstName!',
            spacing: 4,
            description: 'Kenali kulitmu dan dapatkan rekomendasi',
          ),
          AppSpacing.v16,

          RecommendationSummary(totalRecommendations: 5, matchedProducts: 3),
          AppSpacing.v8,

          UvIndex(data: _indexs),
          AppSpacing.v32,

          const AppTitleAction.none(title: 'Aksi Cepat'),
          AppSpacing.v16,
          QuickAction(onItemTap: (title) => _onQuickTap(context, title)),
        ],
      ),
    );
  }
}
