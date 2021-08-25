import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:tasker/shared/theme/app_colors.dart';
import 'package:tasker/shared/theme/app_text_styles.dart';
import 'package:intl/intl.dart';

class InputHourWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final DateFormat format;
  final String? initialValue;
  final String? Function(DateTime?)? validator;
  final TextEditingController? controller;
  final void Function(DateTime? value) onChanged;

  const InputHourWidget(
      {Key? key,
      required this.label,
      this.controller,
      this.initialValue,
      required this.icon,
      this.validator,
      required this.onChanged,
      required this.format})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
      child: DateTimeField(
        // label: label,
        format: format,
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
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child!),
          );
          return DateTimeField.convert(time);
        },
      ),
    );
  }
}
