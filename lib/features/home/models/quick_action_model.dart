class QuickActionModel {
  final String title;
  final dynamic icon;
  final bool isComingSoon;

  const QuickActionModel({
    required this.title,
    required this.icon,
    this.isComingSoon = false,
  });
}
