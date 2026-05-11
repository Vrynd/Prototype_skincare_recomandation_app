import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skincare_recomendation/core/themes/app_spacing.dart';
import 'package:skincare_recomendation/core/widgets/app_scafold.dart';
import 'package:skincare_recomendation/core/widgets/app_location.dart';
import 'package:skincare_recomendation/core/widgets/app_title_action.dart';
import 'package:skincare_recomendation/features/home/data/quick_action_data.dart';
import 'package:skincare_recomendation/features/home/data/recommendation_data.dart';
import 'package:skincare_recomendation/features/home/data/skin_summary_data.dart';
import 'package:skincare_recomendation/features/home/data/uv_index_data.dart';
import 'package:skincare_recomendation/features/home/models/quick_action_model.dart';
import 'package:skincare_recomendation/features/home/models/skin_summary_model.dart';
import 'package:skincare_recomendation/features/home/models/uv_index_model.dart';
import 'package:skincare_recomendation/features/home/models/last_recomendation_model.dart';
import 'package:skincare_recomendation/features/home/presentation/widgets/last_recomendation.dart';
import 'package:skincare_recomendation/features/home/presentation/widgets/skin_summary.dart';
import 'package:skincare_recomendation/features/home/presentation/widgets/uv_index.dart';
import 'package:skincare_recomendation/features/home/presentation/widgets/quick_action.dart';
import 'package:provider/provider.dart';
import 'package:skincare_recomendation/features/home/provider/location_provider.dart';
import 'package:skincare_recomendation/core/utils/app_helpers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String get _greeting => AppHelpers.getGreeting();

  SkinSummaryModel get _summary => SkinSummaryData.skinSummary;
  UvIndexModel get _indexs => UvIndexData.uvIndex;

  List<QuickActionModel> get _actions => QuickActionData.quickActions;
  List<LastRecomendationModel> get _recommendations =>
      RecommendationData.lastRecommendations;

  void _onQuickTap(BuildContext context, int index) {
    final action = _actions[index];
    if (action.isComingSoon) return;

    switch (action.title) {
      case 'Skin Condition':
        // context.pushNamed('skin-condition');
        break;
      case 'Skincare Match':
        // context.pushNamed('skincare-match');
        break;
      default:
        debugPrint('Aksi cepat "${action.title}" diklik');
    }
  }

  void _onRecommendationTap(BuildContext context, LastRecomendationModel item) {
    context.pushNamed('last-recommendation', extra: item.productName);
  }

  @override
  Widget build(BuildContext context) {
    return AppScafold(
      statusBarIconBrightness: Brightness.light,
      header: Consumer<LocationProvider>(
        builder: (context, provider, _) {
          return AppLocation(
            location: provider.address,
            greeting: '$_greeting, Sarah!',
            avatarUrl: 'https://i.pravatar.cc/150?img=47',
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          SkinSummary(data: _summary),
          AppSpacing.v8,
          UvIndex(data: _indexs),
          AppSpacing.v32,

          const AppTitleAction.none(title: 'Aksi Cepat'),
          AppSpacing.v16,
          QuickAction(
            data: _actions,
            onItemTap: (index) => _onQuickTap(context, index),
          ),
          AppSpacing.v32,

          AppTitleAction.button(
            title: 'Rekomendasi Terbaru',
            subtitle: 'Minggu, 10 Mei 2026',
            onPressed: () {},
          ),
          AppSpacing.v16,
          LastRecomendation(
            data: _recommendations,
            onTap: (item) => _onRecommendationTap(context, item),
          ),
        ],
      ),
    );
  }
}
