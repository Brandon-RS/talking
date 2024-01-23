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
      appBarTheme: AppBarTheme(
        backgroundColor: LightColors.scaffoldBackgroundColor,
        iconTheme: const IconThemeData(
          color: LightColors.primary,
        ),
        titleTextStyle: _TextThemeHelper.lightTextTheme.headlineSmall?.copyWith(
          color: LightColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: LightColors.primary,
        onPrimary: LightColors.onPrimary,
        outline: LightColors.outline,
      ),
      iconTheme: const IconThemeData(
        color: LightColors.primary,
      ),
      textTheme: _TextThemeHelper.lightTextTheme,
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 6),
        enableFeedback: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(TColors.white),
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
