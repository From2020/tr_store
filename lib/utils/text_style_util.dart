import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../gen/colors.gen.dart';

class TextFontStyle {
  TextFontStyle._();
  static final headline20StyleMontserrat = GoogleFonts.montserrat(
      color: AppColors.headLine1Color,
      fontSize: 20.sp,
      fontWeight: FontWeight.w700);
  static final headline19StyleMontserrat = GoogleFonts.montserrat(
      color: AppColors.headLine1Color,
      fontSize: 19.sp,
      fontWeight: FontWeight.w600);
  static final headline16StyleMontserrat600 = GoogleFonts.montserrat(
      color: AppColors.headLine1Color,
      fontSize: 16.sp,
      fontWeight: FontWeight.w600);
  static final headline14StyleMontserrat = GoogleFonts.montserrat(
      color: AppColors.headLine1Color,
      fontSize: 14.sp,
      fontWeight: FontWeight.bold);
  static final headline13StyleMontserrat = GoogleFonts.montserrat(
      color: AppColors.headLine1Color,
      fontSize: 13.sp,
      fontWeight: FontWeight.w400);
  static final headline12StyleMontserrat = GoogleFonts.montserrat(
      color: AppColors.headLine1Color,
      fontSize: 12.sp,
      fontWeight: FontWeight.normal);
  static final headline12StyleMontserrat500 = GoogleFonts.montserrat(
      color: AppColors.headLine1Color,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500);
  static final headline14StyleMontserrat400 = GoogleFonts.montserrat(
      color: AppColors.headLine1Color,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400);
}
