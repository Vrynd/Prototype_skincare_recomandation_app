import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_spacing.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/utils/app_validators.dart';
import 'package:skincare_recomendation/core/widgets/app_avatar.dart';
import 'package:skincare_recomendation/core/widgets/app_bottom_sheet.dart';
import 'package:skincare_recomendation/core/widgets/app_button.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';
import 'package:skincare_recomendation/core/widgets/app_text_field.dart';
import 'package:skincare_recomendation/core/widgets/app_tile.dart';
import 'package:skincare_recomendation/features/settings/presentation/widgets/group_title.dart';
import 'package:skincare_recomendation/features/settings/presentation/widgets/confirm_sheet.dart';
import 'package:skincare_recomendation/core/widgets/app_toast.dart';
import 'package:provider/provider.dart';
import 'package:skincare_recomendation/features/auth/provider/auth_provider.dart';

class ProfileSheet extends StatefulWidget {
  final String name;
  final String email;
  final String? avatarUrl;
  final String accountStatus;
  final String joinedDate;

  const ProfileSheet({
    super.key,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.accountStatus,
    required this.joinedDate,
  });

  static Future<void> show({
    required BuildContext context,
    required String name,
    required String email,
    String? avatarUrl,
    required String accountStatus,
    required String joinedDate,
  }) {
    return AppBottomSheet.show(
      context: context,
      backgroundColor: context.colors.surfaceContainerLowest,
      child: ProfileSheet(
        name: name,
        email: email,
        avatarUrl: avatarUrl,
        accountStatus: accountStatus,
        joinedDate: joinedDate,
      ),
    );
  }

  @override
  State<ProfileSheet> createState() => _ProfileSheetState();
}

class _ProfileSheetState extends State<ProfileSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  bool _isEditingName = false;
  bool _isLoading = false;
  bool _isSaved = false;

  bool get _hasUnsavedChanges =>
      _nameController.text.trim() != widget.name && !_isSaved;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
  }

  Future<bool> _showDiscardDialog() async {
    bool discard = false;
    await ConfirmSheet.show(
      context: context,
      title: 'Buang Perubahan?',
      description:
          'Anda memiliki perubahan nama yang belum disimpan. Apakah Anda yakin ingin membuangnya?',
      confirmText: 'Buang',
      cancelText: 'Batal',
      isDanger: true,
      icon: HugeIcons.strokeRoundedAlertCircle,
      onConfirm: () {
        discard = true;
      },
    );
    return discard;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasUnsavedChanges,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final discard = await _showDiscardDialog();
        if (discard && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            AppSpacing.v32,

            const GroupTitle(
              title: 'Informasi Pribadi',
              padding: EdgeInsets.only(bottom: 8),
            ),
            AppTextField(
              controller: _nameController,
              hintText: 'Nama Lengkap',
              icon: HugeIcons.strokeRoundedUser,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.words,
              autofillHints: const [AutofillHints.name],
              validator: AppValidators.validateName,
              readOnly: !_isEditingName,
              suffix: TextButton(
                onPressed: () {
                  setState(() {
                    _isEditingName = !_isEditingName;
                  });
                },
                child: Text(
                  _isEditingName ? 'Selesai' : 'Edit',
                  style: context.text.labelMedium?.copyWith(
                    color: context.colors.tertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            AppSpacing.v20,

            const GroupTitle(
              title: 'Detail Akun',
              padding: EdgeInsets.only(bottom: 8),
            ),
            AppContainer(
              padding: EdgeInsets.zero,
              showShadow: false,
              color: context.colors.onSurfaceVariant,
              opacity: 0.06,
              borderColor: context.colors.outline.withValues(alpha: .2),
              child: Column(
                children: [
                  AppTile.modern(
                    icon: HugeIcons.strokeRoundedMail01,
                    title: 'Email',
                    value: widget.email,
                    valueColor: context.colors.outline,
                    showDivider: true,
                  ),
                  AppTile.modern(
                    icon: HugeIcons.strokeRoundedSecurityCheck,
                    title: 'Status Akun',
                    value: widget.accountStatus,
                    valueColor: context.colors.outline,
                    showDivider: true,
                  ),
                  AppTile.modern(
                    icon: HugeIcons.strokeRoundedCalendar03,
                    title: 'Bergabung Sejak',
                    value: widget.joinedDate,
                    valueColor: context.colors.outline,
                  ),
                ],
              ),
            ),
            AppSpacing.v32,

            AppButton(
              title: 'Simpan Perubahan',
              isLoading: _isLoading,
              onTap: () async {
                if (_nameController.text.trim() == widget.name) {
                  Navigator.pop(context); // Tidak ada perubahan
                  return;
                }

                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _isLoading = true;
                  });

                  final failure = await context
                      .read<AuthProvider>()
                      .updateUserProfile(
                        namaLengkap: _nameController.text.trim(),
                      );

                  if (!context.mounted) return;

                  setState(() {
                    _isLoading = false;
                  });

                  if (failure == null) {
                    setState(() {
                      _isSaved = true;
                    });
                    Navigator.pop(context);
                    AppToast.showSuccess(context, 'Profil berhasil diperbarui!');
                  } else {
                    AppToast.showError(context, failure.message);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Stack(
        children: [
          AppAvatar(
            imageUrl: widget.avatarUrl,
            name: widget.name,
            size: 110,
            borderWidth: 2,
            borderColor: context.colors.tertiary.withValues(alpha: .2),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {},
              child: AppContainer(
                width: null,
                padding: const EdgeInsets.all(8),
                color: context.colors.secondary,
                shape: BoxShape.circle,
                borderColor: context.colors.outlineVariant,
                borderWidth: 2,
                showShadow: false,
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedCamera01,
                  size: 16,
                  color: context.colors.outlineVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
