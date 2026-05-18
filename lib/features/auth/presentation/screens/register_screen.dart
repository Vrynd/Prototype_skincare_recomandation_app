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
import 'package:skincare_recomendation/features/auth/presentation/widgets/social_button.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/social_divider.dart';
import 'package:skincare_recomendation/core/utils/app_validators.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/password_strength_indicator.dart';
import 'package:skincare_recomendation/features/auth/provider/register_provider.dart';
import 'package:provider/provider.dart';
import 'package:skincare_recomendation/features/auth/provider/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _tapToRegister() async {
    if (_formKey.currentState!.validate()) {
      final auth = context.read<AuthProvider>();

      final failure = await auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        namaLengkap: _nameController.text.trim(),
      );

      if (mounted) {
        if (failure == null) {
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

  void _goToLogin() {
    context.pushReplacementNamed('login');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final indicator = context.read<PasswordIndicatorProvider>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AppScafold(
        statusBarIconBrightness: Brightness.light,
        header: AppNavigation(
          showBackButton: false,
          title: 'Register',
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
                            controller: _nameController,
                            hintText: 'Nama Lengkap',
                            icon: HugeIcons.strokeRoundedUser,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            autofillHints: const [AutofillHints.name],
                            validator: AppValidators.validateName,
                          ),

                          AppTextField(
                            controller: _emailController,
                            hintText: 'Alamat Email',
                            icon: HugeIcons.strokeRoundedMail01,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.email],
                            validator: AppValidators.validateEmail,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextField(
                                controller: _passwordController,
                                hintText: 'Kata Sandi',
                                icon: HugeIcons.strokeRoundedLockPassword,
                                isPasswordField: true,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                autofillHints: const [
                                  AutofillHints.newPassword,
                                ],
                                validator: AppValidators.validatePassword,
                                onChanged: indicator.setPassword,
                              ),

                              Consumer<PasswordIndicatorProvider>(
                                builder: (context, provider, child) {
                                  if (provider.password.isEmpty) {
                                    return const SizedBox.shrink();
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 24),
                                    child: PasswordStrengthIndicator(
                                      password: provider.password,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.v24,

                    AppButton(
                      title: 'Daftar Sekarang',
                      isLoading: context.watch<AuthProvider>().isLoading,
                      onTap: _tapToRegister,
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
                      title: 'Sudah punya akun? ',
                      actionTitle: 'Masuk di sini',
                      onTap: () => _goToLogin(),
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
