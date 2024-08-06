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
        checkColor: WidgetStateProperty.all(TColors.white),
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      inputDecorationTheme: _inputDecorator(),
    );
  }

  static InputDecorationTheme _inputDecorator() {
    const borderRadius = BorderRadius.all(Radius.circular(10));

    const borderSide = BorderSide(
      color: LightColors.borderColor,
      width: 2,
    );

    return InputDecorationTheme(
      border: const OutlineInputBorder(borderRadius: borderRadius),
      focusedBorder: const OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: borderSide,
      ),
      iconColor: LightColors.outline,
      prefixIconColor: LightColors.outline,
      suffixIconColor: LightColors.outline,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      hintStyle: _TextThemeHelper.lightTextTheme.labelLarge?.copyWith(
        color: LightColors.onPrimary.withOpacity(.7),
      ),
    );
  }
}
