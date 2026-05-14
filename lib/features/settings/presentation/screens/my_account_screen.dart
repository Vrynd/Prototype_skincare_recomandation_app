import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skincare_recomendation/core/utils/app_helpers.dart';
import 'package:skincare_recomendation/core/widgets/app_location.dart';
import 'package:skincare_recomendation/core/widgets/app_scafold.dart';
import 'package:skincare_recomendation/features/home/provider/location_provider.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_colors.dart';
import 'package:skincare_recomendation/core/themes/app_spacing.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';
import 'package:skincare_recomendation/core/widgets/app_tile.dart';
import 'package:skincare_recomendation/features/settings/presentation/widgets/account_profile.dart';
import 'package:skincare_recomendation/features/settings/presentation/widgets/group_title.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  String get _greeting => AppHelpers.getGreeting();

  @override
  Widget build(BuildContext context) {
    return AppScafold(
      statusBarIconBrightness: Brightness.light,
      showHandle: true,
      header: Consumer<LocationProvider>(
        builder: (context, provider, _) {
          return AppLocation(
            location: provider.address,
            greeting: '$_greeting, Alexandria!',
            avatarUrl: 'https://i.pravatar.cc/150?img=47',
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        children: [
          AccountProfile(
            name: 'Alexandria',
            email: 'alexandria@gmail.com',
            avatarUrl: 'https://i.pravatar.cc/150?img=47',
            isOnline: true,
            onTap: () {},
            accountStatus: 'Aktif',
          ),
          AppSpacing.v20,

          GroupTitle(title: 'Personalisasi'),
          AppContainer(
            padding: EdgeInsets.zero,
            showShadow: false,
            opacity: 0.8,
            child: Column(
              children: [
                AppTile.modern(
                  icon: HugeIcons.strokeRoundedNotification03,
                  iconColor: AppColors.accentAmber,
                  title: 'Notifikasi',
                  value: 'Aktif',
                  onTap: () {},
                  showDivider: true,
                ),
                AppTile.modern(
                  icon: HugeIcons.strokeRoundedTranslation,
                  iconColor: AppColors.accentBlue,
                  title: 'Bahasa',
                  value: 'Indonesia',
                  onTap: () {},
                  showDivider: true,
                ),
                AppTile.modern(
                  icon: HugeIcons.strokeRoundedMoon02,
                  iconColor: AppColors.accentPink,
                  title: 'Mode Tema',
                  value: 'Terang',
                  onTap: () {},
                ),
              ],
            ),
          ),
          AppSpacing.v20,

          GroupTitle(title: 'Privasi & Keamanan'),
          AppContainer(
            showShadow: false,
            opacity: 0.8,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                AppTile.modern(
                  icon: HugeIcons.strokeRoundedKey01,
                  iconColor: AppColors.accentTeal,
                  title: 'Ganti Kata Sandi',
                  onTap: () {},
                  showDivider: true,
                ),
                AppTile.modern(
                  icon: HugeIcons.strokeRoundedUserIdVerification,
                  iconColor: AppColors.accentLavender,
                  title: 'Autentikasi Akun',
                  onTap: () {},
                  showDivider: true,
                ),
                AppTile.modern(
                  icon: HugeIcons.strokeRoundedSecurityCheck,
                  iconColor: AppColors.accentIndigo,
                  title: 'Privasi & Keamanan',
                  onTap: () {},
                ),
              ],
            ),
          ),
          AppSpacing.v20,

          AppContainer(
            showShadow: false,
            opacity: 0.8,
            padding: EdgeInsets.zero,
            child: AppTile.modern(
              icon: HugeIcons.strokeRoundedLogout01,
              title: 'Keluar',
              isDanger: true,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
