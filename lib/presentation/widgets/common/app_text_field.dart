import 'package:flutter/material.dart';
import '../../../config/theme.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? errorText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final Widget? suffix;
  final Widget? prefix;
  final int? maxLines;
  final int? minLines;
  final TextInputAction textInputAction;
  final bool autofocus;

  const AppTextField({
    Key? key,
    required this.label,
    this.hint,
    this.errorText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.suffix,
    this.prefix,
    this.maxLines = 1,
    this.minLines,
    this.textInputAction = TextInputAction.next,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.bodyText2.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
          minLines: minLines,
          textInputAction: textInputAction,
          autofocus: autofocus,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            suffixIcon: suffix,
            prefixIcon: prefix,
          ),
          onChanged: onChanged,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}