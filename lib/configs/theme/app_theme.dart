import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talking/configs/colors/colors.dart';

abstract class AppTheme {
  static final _defaultHeadlineStyle = GoogleFonts.montserratAlternates();

  static ThemeData get light {
    return ThemeData.light().copyWith(
      primaryColor: TColors.primary,
      scaffoldBackgroundColor: TColors.scaffoldBackgroundColor,
      colorScheme: const ColorScheme.light(
        primary: TColors.primary,
        onPrimary: TColors.onPrimary,
      ),
      iconTheme: const IconThemeData(
        color: TColors.primary,
      ),
      textTheme: TextTheme(
        headlineMedium: _defaultHeadlineStyle.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: TColors.onPrimary,
        ),
      ),
    );
  }
}
