import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_spacing.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_button.dart';
import 'package:skincare_recomendation/core/widgets/app_navigation.dart';
import 'package:skincare_recomendation/core/widgets/app_scafold.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/footer_form.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/header_form.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/social_button.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/social_divider.dart';
import 'package:skincare_recomendation/features/auth/presentation/widgets/text_field_form.dart';

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

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {}
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AppScafold(
        statusBarIconBrightness: Brightness.light,
        header: AppNavigation(
          showBackButton: false,
          title: 'Register',
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
                          spacing: 24,
                          children: [
                            TextFieldForm(
                              controller: _nameController,
                              hintText: 'Nama Lengkap',
                              icon: HugeIcons.strokeRoundedUser,
                              keyboardType: TextInputType
                                  .name, // Optimal untuk input nama
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              autofillHints: const [AutofillHints.name],
                              autofocus: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                            TextFieldForm(
                              controller: _emailController,
                              hintText: 'Alamat Email',
                              icon: HugeIcons.strokeRoundedMail01,
                              keyboardType: TextInputType
                                  .emailAddress, // Optimal untuk email
                              textInputAction: TextInputAction.next,
                              autofillHints: const [AutofillHints.email],
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(r'\s')),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email tidak boleh kosong';
                                }
                                if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                ).hasMatch(value)) {
                                  return 'Format email tidak valid';
                                }
                                return null;
                              },
                            ),
                            TextFieldForm(
                              controller: _passwordController,
                              hintText: 'Password',
                              icon: HugeIcons.strokeRoundedLockPassword,
                              isPasswordField: true,
                              keyboardType: TextInputType
                                  .visiblePassword, // Mematikan saran pada password
                              textInputAction: TextInputAction.done,
                              autofillHints: const [AutofillHints.newPassword],
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(r'\s')),
                              ],
                              onFieldSubmitted: (_) => _handleRegister(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }
                                if (value.length < 6) {
                                  return 'Password minimal 6 karakter';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppSpacing.v32,
                    AppButton(title: 'Daftar Sekarang', onTap: _handleRegister),
                    AppSpacing.v24,
                    const SocialDivider(title: 'atau lanjutkan dengan'),
                    AppSpacing.v24,
                    const SocialButton(),
                  ],
                ),
              ),
            ),
            FooterForm(
              title: 'Sudah punya akun? ',
              actionTitle: 'Masuk di sini',
              onTap: () => context.pushReplacementNamed('login'),
            ),
          ],
        ),
      ),
    );
  }
}
