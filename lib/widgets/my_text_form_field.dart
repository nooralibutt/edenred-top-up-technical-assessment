import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_top_up/utilities/app_theme.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final String? hint;
  final String? prefixText;
  final IconData? icon;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textInputFormatter;
  final void Function(String)? onChanged;

  const MyTextFormField({
    super.key,
    required this.textEditingController,
    required this.label,
    this.hint,
    this.icon,
    this.textInputType,
    this.textInputFormatter,
    this.prefixText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: textInputType ?? TextInputType.text,
      onChanged: onChanged,
      autocorrect: false,
      decoration: InputDecoration(
        label: Text(label),
        hintText: hint,
        icon: icon != null ? Icon(icon) : null,
        prefixText: prefixText,
      ),
      style: context.titleMedium!.copyWith(color: AppTheme.mediumBlack),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      inputFormatters: textInputFormatter,
    );
  }
}
