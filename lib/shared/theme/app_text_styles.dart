import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasker/shared/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';

class AppTextStyles {
  static final titleSplash = GoogleFonts.lexendDeca(
      fontSize: 52,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
      letterSpacing: -1,
      shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.3),
          offset: Offset(0, 0),
          blurRadius: 25,
        )
      ]);

  static final titleRegular = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static final titleBoldBackground = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static final captionShape = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.white.withOpacity(0.8),
  );

  static final captionWhite = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static final buttonBarBoldGrey = GoogleFonts.lexendDeca(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.grey,
  );

  static final buttonBarGrey = GoogleFonts.lexendDeca(
    fontSize: 13,
    color: AppColors.grey,
  );

  static final buttonBarWhite = GoogleFonts.lexendDeca(
    fontSize: 13,
    color: AppColors.white,
  );

  static final titleBoldHeading = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.grey,
  );

  static final titleListTile = GoogleFonts.lexendDeca(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.grey,
  );

  static final captionBody = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.body,
  );

  static final input = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );

  static final inputWhite = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );
}
