import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_spacing.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_button.dart';
import 'package:skincare_recomendation/core/widgets/app_navigation.dart';
import 'package:skincare_recomendation/core/widgets/app_scafold.dart';
import 'package:skincare_recomendation/core/widgets/app_text_field.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/footer_form.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/header_form.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/remember_recovery.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/social_button.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/social_divider.dart';
import 'package:skincare_recomendation/core/utils/app_validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _tapToLogin() async {
    context.pushNamed('home');
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          titleStyle: context.text.displayMedium?.copyWith(
            color: context.colors.surface,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderForm(),
                    AppSpacing.v24,

                    Form(
                      key: _formKey,
                      child: AutofillGroup(
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
                              hintText: 'Password',
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
                    ),
                    AppSpacing.v24,

                    AppButton(title: 'Login Sekarang', onTap: _tapToLogin),
                    AppSpacing.v24,

                    const SocialDivider(title: 'atau lanjutkan dengan'),
                    AppSpacing.v24,

                    const SocialButton(),
                  ],
                ),
              ),
            ),

            FooterForm(
              title: 'Belum punya akun? ',
              actionTitle: 'Daftar Sekarang',
              onTap: () => _goToRegister(),
            ),
          ],
        ),
      ),
    );
  }
}
