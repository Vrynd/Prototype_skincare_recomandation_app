import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/themes/app_radius.dart';
import 'package:skincare_recomendation/core/themes/app_spacing.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';
import 'package:skincare_recomendation/core/widgets/app_scafold.dart';
import 'package:skincare_recomendation/core/widgets/app_location.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScafold(
      statusBarIconBrightness: Brightness.light,
      header: const AppLocation(
        location: 'Kab Pati, Jawa Tengah',
        greeting: 'Selamat Pagi Sarah!',
        avatarUrl: 'https://i.pravatar.cc/150?img=47',
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        children: [
          AppContainer(
            height: 160,
            borderRadius: AppRadius.br24,
            showShadow: false,
            opacity: .6,
          ),
          AppSpacing.v16,
          AppContainer(
            height: 160,
            borderRadius: AppRadius.br24,
            showShadow: false,
            opacity: .6,
          ),
        ],
      ),
    );
  }
}
