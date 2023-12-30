import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talking/configs/colors/generic_colors.dart';

import '../colors/light_colors.dart';

part 'text_theme.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData.light().copyWith(
      primaryColor: LightColors.primary,
      scaffoldBackgroundColor: LightColors.scaffoldBackgroundColor,
      colorScheme: const ColorScheme.light(
        primary: LightColors.primary,
        onPrimary: LightColors.onPrimary,
        outline: LightColors.outline,
      ),
      iconTheme: const IconThemeData(
        color: LightColors.primary,
      ),
      textTheme: _TextThemeHelper.lightTextTheme,
    );
  }
}
