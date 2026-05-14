import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/themes/app_colors.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';

class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double size;
  final bool isOnline;
  final double? borderWidth;
  final Color? borderColor;

  const AppAvatar({
    super.key,
    this.imageUrl,
    required this.name,
    this.size = 48,
    this.isOnline = false,
    this.borderWidth,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final double indicatorSize = size * 0.25;
    final double indicatorBorder = indicatorSize * 0.18;

    final bool hasImage = imageUrl != null && imageUrl!.isNotEmpty;
    final Color backgroundColor = _getBackgroundColor();

    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor.withValues(alpha: 0.15),
            border: Border.all(
              color:
                  borderColor ?? context.colors.surface.withValues(alpha: 0.8),
              width: borderWidth ?? 0,
            ),
          ),
          child: ClipOval(
            child: hasImage
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildInitials(context, backgroundColor);
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: SizedBox(
                          width: size * 0.4,
                          height: size * 0.4,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  )
                : _buildInitials(context, backgroundColor),
          ),
        ),
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: indicatorSize,
              height: indicatorSize,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.colors.surfaceContainerLowest,
                  width: indicatorBorder.clamp(1.5, 3.0),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInitials(BuildContext context, Color backgroundColor) {
    return Center(
      child: Text(
        _getInitials(),
        style: context.text.titleMedium?.copyWith(
          color: backgroundColor,
          fontWeight: FontWeight.w600,
          fontSize: size * 0.38,
        ),
      ),
    );
  }

  String _getInitials() {
    if (name.isEmpty) return '';
    final parts = name.trim().split(' ');
    if (parts.length > 1) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  Color _getBackgroundColor() {
    final List<Color> accentColors = [
      AppColors.accentPurple,
      AppColors.accentOrange,
      AppColors.accentPink,
      AppColors.accentIndigo,
      AppColors.accentBlue,
      AppColors.accentTeal,
      AppColors.accentAmber,
      AppColors.accentRed,
      AppColors.accentLavender,
      AppColors.accentSage,
      AppColors.accentCyan,
    ];

    final int index =
        name.toLowerCase().codeUnits.fold(0, (prev, curr) => prev + curr) %
        accentColors.length;
    return accentColors[index];
  }
}
