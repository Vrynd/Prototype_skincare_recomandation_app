import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:go_router/go_router.dart';
import 'package:skincare_recomendation/core/themes/app_spacing.dart';
import 'package:skincare_recomendation/core/utils/app_validators.dart';
import 'package:skincare_recomendation/core/widgets/app_navigation.dart';
import 'package:skincare_recomendation/core/widgets/app_scafold.dart';
import 'package:skincare_recomendation/core/widgets/app_text_field.dart';
import 'package:skincare_recomendation/core/widgets/app_title_header.dart';
import 'package:skincare_recomendation/core/widgets/app_title_footer.dart';
import 'package:skincare_recomendation/core/widgets/app_toast.dart';
import 'package:skincare_recomendation/features/settings/presentation/widgets/group_title.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulasi pembaruan kata sandi
    await Future.delayed(const Duration(milliseconds: 1500));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      AppToast.showSuccess(context, 'Kata sandi Anda berhasil diperbarui');

      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScafold(
      statusBarIconBrightness: Brightness.light,
      showHandle: true,
      header: const AppNavigation(title: 'Ganti Kata Sandi'),
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const AppTitleHeader.form(
                    title: 'Perbarui Kata Sandi Anda',
                    description:
                        'Untuk terus melindungi akun personal Anda, silakan lakukan pembaruan kata sandi secara berkala',
                  ),
                  AppSpacing.v24,

                  AutofillGroup(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GroupTitle(
                          title: 'Kata Sandi Lama',
                          padding: const EdgeInsets.only(left: 0, bottom: 10),
                        ),
                        AppTextField(
                          controller: _currentPasswordController,
                          hintText: 'Masukkan kata sandi lama',
                          icon: HugeIcons.strokeRoundedKey01,
                          isPasswordField: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) =>
                              AppValidators.validateRequired(
                            value,
                            'Kata sandi lama',
                          ),
                        ),
                        AppSpacing.v24,

                        GroupTitle(
                          title: 'Kata Sandi Baru',
                          padding: const EdgeInsets.only(left: 0, bottom: 10),
                        ),
                        AppTextField(
                          controller: _newPasswordController,
                          hintText: 'Buat kata sandi baru',
                          icon: HugeIcons.strokeRoundedKey01,
                          isPasswordField: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          validator: AppValidators.validatePassword,
                        ),
                        AppSpacing.v24,

                        GroupTitle(
                          title: 'Konfirmasi Kata Sandi Baru',
                          padding: const EdgeInsets.only(left: 0, bottom: 10),
                        ),
                        AppTextField(
                          controller: _confirmPasswordController,
                          hintText: 'Konfirmasi kata sandi baru',
                          icon: HugeIcons.strokeRoundedKey01,
                          isPasswordField: true,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) =>
                              AppValidators.validateConfirmPassword(
                            value,
                            _newPasswordController.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(),
                  AppTitleFooter.button(
                    title: 'Simpan Perubahan',
                    isLoading: _isLoading,
                    onTap: _submit,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
