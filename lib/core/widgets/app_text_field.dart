import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_radius.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';

/// Widget Input Teks standar proyek dengan desain "Quiet Luxury".
class AppTextField extends StatefulWidget {
  final String hintText;
  final dynamic icon;
  final bool isPasswordField;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final bool autofocus;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onChanged;

  const AppTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPasswordField = false,
    this.keyboardType,
    this.controller,
    this.validator,
    this.textInputAction,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.enabled = true,
    this.autofocus = false,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPasswordField;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      autofillHints: widget.autofillHints,
      textCapitalization: widget.textCapitalization,
      style: _getTextStyle(context),
      decoration: _getInputDecoration(context),
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    return context.text.titleLarge!.copyWith(
      fontWeight: FontWeight.w500,
      color: widget.enabled ? context.colors.onSurface : context.colors.outline,
    );
  }

  InputDecoration _getInputDecoration(BuildContext context) {
    final outlineColor = context.colors.outline.withValues(alpha: 0.2);

    return InputDecoration(
      hintText: widget.hintText,
      hintStyle: context.text.bodyLarge?.copyWith(
        color: context.colors.outline.withValues(alpha: 0.7),
      ),
      prefixIcon: _buildPrefixIcon(context),
      suffixIcon: _buildSuffixIcon(context),
      filled: true,
      fillColor: context.colors.onSurfaceVariant.withValues(alpha: 0.06),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      border: _getBorder(outlineColor, 1),
      enabledBorder: _getBorder(outlineColor, 1),
      focusedBorder: _getBorder(context.colors.primary, 1.3),
      errorBorder: _getBorder(context.colors.error, 1),
      focusedErrorBorder: _getBorder(context.colors.error, 1.3),
      counterText: '',
    );
  }

  OutlineInputBorder _getBorder(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: AppRadius.br16,
      borderSide: BorderSide(color: color, width: width),
    );
  }

  Widget? _buildPrefixIcon(BuildContext context) {
    final color = widget.enabled
        ? context.colors.onSurface
        : context.colors.outline;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: widget.icon is List<List<dynamic>>
          ? HugeIcon(icon: widget.icon, color: color, size: 22)
          : Icon(widget.icon, color: color, size: 22),
    );
  }

  Widget? _buildSuffixIcon(BuildContext context) {
    if (!widget.isPasswordField) return null;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => setState(() => _obscureText = !_obscureText),
          borderRadius: AppRadius.br12,
          splashColor: context.colors.onSurface.withValues(alpha: .1),
          highlightColor: context.colors.onSurface.withValues(alpha: .05),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: HugeIcon(
              icon: _obscureText
                  ? HugeIcons.strokeRoundedViewOffSlash
                  : HugeIcons.strokeRoundedView,
              color: context.colors.outline,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
