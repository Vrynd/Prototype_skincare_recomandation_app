import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skincare_recomendation/core/themes/app_radius.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';

class TextFieldForm extends StatefulWidget {
  final String hintText;
  final dynamic icon;
  final bool isPasswordField;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final bool readOnly;
  final FocusNode? focusNode;
  final bool autofocus;
  final int? maxLength;
  final int maxLines;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;

  const TextFieldForm({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPasswordField = false,
    this.keyboardType,
    this.controller,
    this.validator,
    this.textInputAction,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.enabled = true,
    this.readOnly = false,
    this.focusNode,
    this.autofocus = false,
    this.maxLength,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
  });

  @override
  State<TextFieldForm> createState() => _TextFieldFormState();
}

class _TextFieldFormState extends State<TextFieldForm> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPasswordField;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.colors.onSurfaceVariant.withValues(alpha: 0.06),
            borderRadius: AppRadius.br16,
          ),
          child: TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            obscureText: _obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onFieldSubmitted,
            inputFormatters: widget.inputFormatters,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            textCapitalization: widget.textCapitalization,
            autofillHints: widget.autofillHints,
            style: context.text.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: widget.enabled ? context.colors.onSurface : context.colors.outline,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: context.text.bodyLarge?.copyWith(
                color: context.colors.outline.withValues(alpha: 0.7),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: HugeIcon(
                  icon: widget.icon,
                  color: widget.enabled ? context.colors.onSurface : context.colors.outline,
                  size: 22,
                ),
              ),
              suffixIcon: widget.isPasswordField
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: HugeIcon(
                          icon: _obscureText
                              ? HugeIcons.strokeRoundedViewOffSlash
                              : HugeIcons.strokeRoundedView,
                          color: context.colors.outline,
                          size: 20,
                        ),
                      ),
                    )
                  : null,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: AppRadius.br16,
                borderSide: BorderSide(color: context.colors.primary, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: AppRadius.br16,
                borderSide: BorderSide(color: context.colors.error, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: AppRadius.br16,
                borderSide: BorderSide(color: context.colors.error, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
              counterText: '',
            ),
          ),
        ),
      ],
    );
  }
}
