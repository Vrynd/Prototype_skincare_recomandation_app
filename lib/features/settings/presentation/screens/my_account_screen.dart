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
import 'package:skincare_recomendation/features/settings/presentation/widgets/confirm_sheet.dart';
import 'package:skincare_recomendation/features/settings/presentation/widgets/profile_sheet.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  String get _greeting => AppHelpers.getGreeting();

  void _goToChangePassword() async {}

  void _goToAuthentication() async {}

  void _goToPrivacy() async {}

  void _tapToNotification() async {}

  void _tapToLanguage() async {}

  void _tapToTheme() async {}

  void _showProfileDetail() {
    ProfileSheet.show(
      context: context,
      name: 'Sarah Fatimatuz Zahra',
      email: 'sarahftz@gmail.com',
      avatarUrl: null,
      accountStatus: 'Aktif',
      joinedDate: '12 Mei 2024',
    );
  }

  void _tapToLogout() async {
    ConfirmSheet.show(
      context: context,
      title: 'Keluar Akun',
      description:
          'Apakah Anda yakin ingin keluar dari akun Alexandria? Anda perlu masuk kembali nanti.',
      confirmText: 'Ya, Keluar',
      isDanger: true,
      icon: HugeIcons.strokeRoundedLogout01,
      onConfirm: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScafold(
      statusBarIconBrightness: Brightness.light,
      showHandle: true,
      header: Consumer<LocationProvider>(
        builder: (context, provider, _) {
          return AppLocation(
            location: provider.address,
            userName: 'Sarah Fatimatuz Zahra',
            greeting: '$_greeting, Sarah!',
            avatarUrl: null,
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        children: [
          AccountProfile(
            name: 'Sarah Fatimatuz Zahra',
            email: 'sarahftz@gmail.com',
            avatarUrl: null,
            isOnline: true,
            accountStatus: 'Aktif',
            onTap: () => _showProfileDetail(),
          ),
          AppSpacing.v20,

          const GroupTitle(title: 'Personalisasi'),
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
                  onTap: () => _tapToNotification(),
                  showDivider: true,
                ),
                AppTile.modern(
                  icon: HugeIcons.strokeRoundedTranslation,
                  iconColor: AppColors.accentBlue,
                  title: 'Bahasa',
                  value: 'Indonesia',
                  onTap: () => _tapToLanguage(),
                  showDivider: true,
                ),
                AppTile.modern(
                  icon: HugeIcons.strokeRoundedMoon02,
                  iconColor: AppColors.accentPink,
                  title: 'Mode Tema',
                  value: 'Terang',
                  onTap: () => _tapToTheme(),
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
                  onTap: () => _goToChangePassword(),
                  showDivider: true,
                ),
                AppTile.modern(
                  icon: HugeIcons.strokeRoundedUserIdVerification,
                  iconColor: AppColors.accentLavender,
                  title: 'Autentikasi Akun',
                  onTap: () => _goToAuthentication(),
                  showDivider: true,
                ),
                AppTile.modern(
                  icon: HugeIcons.strokeRoundedSecurityCheck,
                  iconColor: AppColors.accentIndigo,
                  title: 'Privasi & Keamanan',
                  onTap: () => _goToPrivacy(),
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
              onTap: () => _tapToLogout(),
            ),
          ),
        ],
      ),
    );
  }
}
