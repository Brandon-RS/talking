import 'package:flutter/material.dart';
import 'package:talking/configs/colors/colors.dart';

class AppTheme {
  static final light = ThemeData.light().copyWith(
    primaryColor: TColors.primary,
    scaffoldBackgroundColor: TColors.scaffoldBackgroundColor,
  );
}
