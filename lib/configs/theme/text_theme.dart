part of 'app_theme.dart';

abstract class _TextThemeHelper {
  static final _defaultHeadlineStyle = GoogleFonts.montserratAlternates(
    color: LightColors.onPrimary,
    fontWeight: FontWeight.normal,
  );

  static final _defaultBodyStyle = GoogleFonts.roboto(
    color: LightColors.onPrimary,
    fontWeight: FontWeight.normal,
  );

  static final _defaultLabelStyle = GoogleFonts.openSans(
    color: TColors.white,
    fontWeight: FontWeight.w600,
  );

  static TextTheme get lightTextTheme {
    return TextTheme(
      headlineLarge: _defaultHeadlineStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: _defaultHeadlineStyle.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: _defaultHeadlineStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: _defaultBodyStyle.copyWith(
        fontSize: 16,
      ),
      bodyMedium: _defaultBodyStyle.copyWith(
        fontSize: 14,
      ),
      bodySmall: _defaultBodyStyle.copyWith(
        fontSize: 12,
      ),
      labelLarge: _defaultLabelStyle.copyWith(
        fontSize: 15,
      ),
    );
  }
}
