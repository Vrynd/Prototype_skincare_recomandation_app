import 'package:skincare_recomendation/features/home/models/last_recomendation_model.dart';

class RecommendationData {
  RecommendationData._();

  static List<LastRecomendationModel> get lastRecommendations => [
    LastRecomendationModel(
      brandName: 'Somethinc',
      productName: 'Hydrating Gel Moisturizer',
      category: 'Moisturizer',
      uvIndex: 8,
      createdAt: DateTime.now(),
    ),
    LastRecomendationModel(
      brandName: 'Skin Game',
      productName: 'Sunscreen SPF 50+',
      category: 'Sunscreen',
      uvIndex: 10,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    LastRecomendationModel(
      brandName: 'Cetaphil',
      productName: 'Gentle Cleanser',
      category: 'Cleanser',
      uvIndex: 4,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];
}
