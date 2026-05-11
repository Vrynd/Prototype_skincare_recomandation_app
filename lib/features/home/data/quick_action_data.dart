import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/features/home/models/quick_action_model.dart';

class QuickActionData {
  QuickActionData._();

  static List<QuickActionModel> get quickActions => [
    QuickActionModel(
      title: 'Skin Condition',
      icon: HugeIcons.strokeRoundedFaceId,
    ),
    QuickActionModel(
      title: 'Skincare Match',
      icon: HugeIcons.strokeRoundedPuzzle,
    ),
    QuickActionModel(
      title: 'Daily Routine',
      icon: HugeIcons.strokeRoundedTaskDaily02,
      isComingSoon: true,
    ),
    QuickActionModel(
      title: 'Skin Preference',
      icon: HugeIcons.strokeRoundedSlidersHorizontal,
      isComingSoon: true,
    ),
  ];
}
