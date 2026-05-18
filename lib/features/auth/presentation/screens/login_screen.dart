import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_spacing.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_button.dart';
import 'package:skincare_recomendation/core/widgets/app_navigation.dart';
import 'package:skincare_recomendation/core/widgets/app_scafold.dart';
import 'package:skincare_recomendation/core/widgets/app_text_field.dart';
import 'package:skincare_recomendation/core/widgets/app_title_footer.dart';
import 'package:skincare_recomendation/core/widgets/app_title_header.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/remember_recovery.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/social_button.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/social_divider.dart';
import 'package:skincare_recomendation/core/utils/app_validators.dart';
import 'package:provider/provider.dart';
import 'package:skincare_recomendation/core/services/storage_service.dart';
import 'package:skincare_recomendation/features/auth/provider/auth_provider.dart';
import 'package:skincare_recomendation/features/auth/provider/remember_me_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSavedEmail();
    });
  }

  void _loadSavedEmail() {
    final storage = context.read<StorageService>();
    final rememberMe = context.read<RememberMeProvider>();

    final isRemembered = storage.getBool(StorageService.keyRememberMe);
    if (isRemembered) {
      final savedEmail = storage.getString(StorageService.keySavedEmail);
      if (savedEmail != null) {
        _emailController.text = savedEmail;
        rememberMe.setRememberMe(true);
      }
    }
  }

  void _tapToLogin() async {
    if (_formKey.currentState!.validate()) {
      final auth = context.read<AuthProvider>();

      final failure = await auth.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted) {
        if (failure == null) {
          final storage = context.read<StorageService>();
          final rememberMe = context.read<RememberMeProvider>();

          if (rememberMe.isRememberMe) {
            storage.setBool(StorageService.keyRememberMe, true);
            storage.setString(
              StorageService.keySavedEmail,
              _emailController.text.trim(),
            );
          } else {
            storage.setBool(StorageService.keyRememberMe, false);
            storage.remove(StorageService.keySavedEmail);
          }

          context.pushReplacementNamed('home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(failure.message),
              backgroundColor: context.colors.error,
            ),
          );
        }
      }
    }
  }

  void _goToRegister() {
    context.pushReplacementNamed('register');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AppScafold(
        statusBarIconBrightness: Brightness.light,
        header: AppNavigation(
          showBackButton: false,
          title: 'Sign In',
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          titleStyle: context.text.displayMedium?.copyWith(
            color: context.colors.surface,
          ),
        ),
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const AppTitleHeader(
                      title: 'Selamat Datang Kembali!',
                      description:
                          'Untuk tetap terhubung dengan kami, silakan masuk\ndengan informasi Anda',
                    ),
                    AppSpacing.v24,

                    AutofillGroup(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 24,
                        children: [
                          AppTextField(
                            controller: _emailController,
                            hintText: 'Alamat Email',
                            icon: HugeIcons.strokeRoundedMail01,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.email],
                            validator: AppValidators.validateEmail,
                          ),

                          AppTextField(
                            controller: _passwordController,
                            hintText: 'Kata Sandi',
                            icon: HugeIcons.strokeRoundedLockPassword,
                            isPasswordField: true,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.password],
                            validator: AppValidators.validatePassword,
                          ),

                          const RememberRecovery(),
                        ],
                      ),
                    ),
                    AppSpacing.v24,

                    AppButton(
                      title: 'Login Sekarang',
                      isLoading: context.watch<AuthProvider>().isLoading,
                      onTap: _tapToLogin,
                    ),
                    AppSpacing.v24,

                    const SocialDivider(title: 'atau lanjutkan dengan'),
                    AppSpacing.v24,

                    const SocialButton(),
                  ]),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(),
                    AppTitleFooter(
                      title: 'Belum punya akun? ',
                      actionTitle: 'Daftar Sekarang',
                      onTap: () => _goToRegister(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
