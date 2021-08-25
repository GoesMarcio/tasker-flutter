import 'package:flutter/material.dart';
import 'package:tasker/shared/theme/app_colors.dart';
import 'package:tasker/shared/theme/app_text_styles.dart';

class TagWidget extends StatelessWidget {
  final String text;
  final Color? color;
  const TagWidget({Key? key, required this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color ?? AppColors.primary,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        child: Text(text, style: AppTextStyles.buttonBarWhite),
      ),
    );
  }
}
