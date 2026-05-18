import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skincare_recomendation/core/utils/app_helpers.dart';
import 'package:skincare_recomendation/core/widgets/app_location.dart';
import 'package:skincare_recomendation/core/widgets/app_scafold.dart';
import 'package:skincare_recomendation/features/auth/provider/auth_provider.dart';
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
import 'package:skincare_recomendation/features/settings/presentation/widgets/notification_sheet.dart';
import 'package:skincare_recomendation/features/settings/presentation/widgets/languange_sheet.dart';
import 'package:skincare_recomendation/features/settings/presentation/widgets/theme_sheet.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  String _notificationStatus = 'Aktif';
  String _language = 'Indonesia';
  String _themeMode = 'Terang';

  String get _greeting => AppHelpers.getGreeting();

  void _goToChangePassword() {
    context.pushNamed('change-password');
  }

  void _goToAuthentication() async {}

  void _goToPrivacy() async {}

  void _tapToNotification() async {
    NotificationSheet.show(
      context: context,
      currentValue: _notificationStatus,
      onSelected: (value) {
        setState(() {
          _notificationStatus = value;
        });
      },
    );
  }

  void _tapToLanguage() async {
    LanguangeSheet.show(
      context: context,
      currentValue: _language,
      onSelected: (value) {
        setState(() {
          _language = value;
        });
      },
    );
  }

  void _tapToTheme() async {
    ThemeSheet.show(
      context: context,
      currentValue: _themeMode,
      onSelected: (value) {
        setState(() {
          _themeMode = value;
        });
      },
    );
  }

  String _formatJoinedDate(DateTime? dateTime) {
    if (dateTime == null) return 'Baru Terdaftar';
    final months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}';
  }

  void _showProfileDetail() {
    final user = context.read<AuthProvider>().userProfile;
    final name = user?.namaLengkap ?? 'Pengguna';
    final email = user?.email ?? 'email@domain.com';
    
    ProfileSheet.show(
      context: context,
      name: name,
      email: email,
      avatarUrl: user?.fotoProfile,
      accountStatus: user?.statusAkun == true ? 'Aktif' : 'Nonaktif',
      joinedDate: _formatJoinedDate(user?.createdAt),
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
      onConfirm: () {
        context.read<AuthProvider>().signOut();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().userProfile;
    final fullName = user?.namaLengkap ?? 'Pengguna';
    final firstName = fullName.split(' ').first;
    final email = user?.email ?? 'email@domain.com';

    return AppScafold(
      statusBarIconBrightness: Brightness.light,
      showHandle: true,
      header: Consumer<LocationProvider>(
        builder: (context, provider, _) {
          return AppLocation(
            location: provider.address,
            userName: fullName,
            greeting: '$_greeting, $firstName!',
            avatarUrl: user?.fotoProfile,
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        children: [
          AccountProfile(
            name: fullName,
            email: email,
            avatarUrl: user?.fotoProfile,
            isOnline: true,
            accountStatus: user?.statusAkun == true ? 'Aktif' : 'Nonaktif',
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
                  icon: _notificationStatus == 'Aktif'
                      ? HugeIcons.strokeRoundedNotification01
                      : HugeIcons.strokeRoundedNotificationOff01,
                  iconColor: AppColors.accentAmber,
                  title: 'Notifikasi',
                  value: _notificationStatus,
                  onTap: () => _tapToNotification(),
                  showDivider: true,
                ),
                AppTile.modern(
                  icon: _language == 'Indonesia'
                      ? HugeIcons.strokeRoundedTranslation
                      : HugeIcons.strokeRoundedGlobal,
                  iconColor: AppColors.accentBlue,
                  title: 'Bahasa',
                  value: _language,
                  onTap: () => _tapToLanguage(),
                  showDivider: true,
                ),
                AppTile.modern(
                  icon: _themeMode == 'Terang'
                      ? HugeIcons.strokeRoundedSun03
                      : _themeMode == 'Gelap'
                      ? HugeIcons.strokeRoundedMoon02
                      : HugeIcons.strokeRoundedSettings03,
                  iconColor: AppColors.accentPink,
                  title: 'Mode Tema',
                  value: _themeMode,
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
