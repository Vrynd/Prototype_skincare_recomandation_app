import 'package:skincare_recomendation/features/home/models/uv_index_model.dart';

class UvIndexData {
  UvIndexData._();

  static UvIndexModel get uvIndex =>
      UvIndexModel(currentUv: 8, forecastUv: [8, 5, 9, 4, 12, 6, 7]);
}
