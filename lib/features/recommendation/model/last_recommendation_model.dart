class LastRecommendationModel {
  final String? lastDate;
  final String? skinType;
  final String? skinConcern;
  final String? uvIndex;

  const LastRecommendationModel({
    this.lastDate,
    this.skinType,
    this.skinConcern,
    this.uvIndex,
  });

  /// Factory untuk parsing data
  factory LastRecommendationModel.fromMap(Map<String, dynamic> map) {
    return LastRecommendationModel(
      lastDate: map['last_date'] as String?,
      skinType: map['skin_type'] as String?,
      skinConcern: map['skin_concern'] as String?,
      uvIndex: map['uv_index']?.toString(),
    );
  }

  /// Konversi ke Map
  Map<String, dynamic> toMap() {
    return {
      'last_date': lastDate,
      'skin_type': skinType,
      'skin_concern': skinConcern,
      'uv_index': uvIndex,
    };
  }
}
