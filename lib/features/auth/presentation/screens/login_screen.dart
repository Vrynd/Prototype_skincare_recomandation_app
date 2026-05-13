import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_spacing.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_button.dart';
import 'package:skincare_recomendation/core/widgets/app_navigation.dart';
import 'package:skincare_recomendation/core/widgets/app_scafold.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/header_form.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/remember_recovery.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/social_button.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/social_divider.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/text_field_form.dart';

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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScafold(
      statusBarIconBrightness: Brightness.light,
      header: AppNavigation(
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
                    child: Column(
                      spacing: 24,
                      children: [
                        TextFieldForm(
                          controller: _emailController,
                          hintText: 'Email Address',
                          icon: HugeIcons.strokeRoundedMail01,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        TextFieldForm(
                          controller: _passwordController,
                          hintText: 'Password',
                          icon: HugeIcons.strokeRoundedLockPassword,
                          isPasswordField: true,
                        ),

                        const RememberRecovery(),
                      ],
                    ),
                  ),
                  AppSpacing.v24,

                  AppButton(
                    title: 'Login Sekarang',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                  ),
                  AppSpacing.v24,

                  const SocialDivider(title: 'atau lanjutkan dengan'),
                  AppSpacing.v24,

                  const SocialButton(),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Belum punya akun? ',
                  style: context.text.bodyMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Daftar Sekarang',
                    style: context.text.bodyMedium?.copyWith(
                      color: context.colors.primary,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
