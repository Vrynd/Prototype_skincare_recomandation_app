import 'package:skincare_recomendation/features/home/models/skin_summary_model.dart';

class SkinSummaryData {
  SkinSummaryData._();

  static SkinSummaryModel get skinSummary => SkinSummaryModel(
    skinType: 'Normal',
    skinCondition: 'Berjerawat',
    lastUpdated: '10 Januari 2026',
  );
}
