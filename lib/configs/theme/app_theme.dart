import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talking/configs/colors/colors.dart';

part 'light/text_theme.dart';

abstract class AppTheme {
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
      textTheme: _TextThemeHelper.lightTextTheme,
    );
  }
}
