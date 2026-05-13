import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';

class HeaderForm extends StatelessWidget {
  final String title;
  final String description;
  const HeaderForm({
    super.key,
    this.title = 'Selamat Datang Kembali!',
    this.description =
        'Untuk tetap terhubung dengan kami, silakan masuk\ndengan informasi Anda',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Text(
          title,
          style: context.text.displaySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          description,
          style: context.text.bodyLarge?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
