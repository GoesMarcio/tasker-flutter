import 'package:flutter/material.dart';
import 'package:tasker/shared/theme/app_colors.dart';
import 'package:tasker/shared/theme/app_text_styles.dart';

class InputTextWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String value) onChanged;

  const InputTextWidget(
      {Key? key,
      required this.label,
      this.controller,
      this.initialValue,
      required this.icon,
      this.validator,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
      child: TextFormField(
        // label: label,
        validator: validator,
        controller: controller,
        onChanged: onChanged,
        style: AppTextStyles.input,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: AppColors.primary)),
          labelText: label,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
          prefixIcon: Icon(
            icon,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
