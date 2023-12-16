import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as fonts;

abstract class AppTheme {
  String get appFont;

  Brightness get brightness;

  //colors
  Color get colorPrimary;

  Color get colorSecondary;

  Color get colorBlack;

  Color get colorBackground;

  Color get colorText;

  Color get colorTextSecondary;

  Color get colorIcon;

  Color get colorInactive;

  Color get colorNavbar;

  Color get colorActive;

  Color get colorActive2;

  Color get colorError;

  Color get colorWarning;

  Color get colorSuccess;

  //text
  TextStyle get textSuperHeader => TextStyle(fontSize: 35.0, color: colorText, fontWeight: FontWeight.bold);

  TextStyle get textHeader => TextStyle(fontSize: 18.0, color: colorText, fontWeight: FontWeight.bold);

  TextStyle get textTitle => TextStyle(
        fontSize: 15.0,
        color: colorText,
        fontWeight: FontWeight.normal,
      );

  TextStyle get textBody => TextStyle(
        fontSize: 12.0,
        color: colorText,
        fontWeight: FontWeight.normal,
      );

  TextStyle get textNote => TextStyle(
        fontSize: 10.0,
        color: colorText,
        fontWeight: FontWeight.normal,
      );

  ThemeData get themeData {
    final ThemeData theme = ThemeData(
        brightness: brightness,
        fontFamily: appFont,
        scaffoldBackgroundColor: colorBackground,
        primaryColor: colorPrimary,
        primaryColorLight: colorPrimary,
        primaryColorDark: colorPrimary,
        primarySwatch: materialColor(colorPrimary),
        textTheme: fonts.GoogleFonts.poppinsTextTheme(TextTheme(
          displayMedium: textSuperHeader,
          displaySmall: textHeader,
          headlineSmall: textHeader,
          titleMedium: textTitle,
          titleSmall: textTitle,
          bodyLarge: textBody,
          bodyMedium: textBody,
        )));

    return theme;
  }

  MaterialColor materialColor(Color color) {
    return MaterialColor(color.value, {
      50: color.withAlpha((255 * 0.1).round()),
      100: color.withAlpha((255 * 0.2).round()),
      200: color.withAlpha((255 * 0.3).round()),
      300: color.withAlpha((255 * 0.4).round()),
      400: color.withAlpha((255 * 0.5).round()),
      500: color.withAlpha((255 * 0.6).round()),
      600: color.withAlpha((255 * 0.7).round()),
      700: color.withAlpha((255 * 0.8).round()),
      800: color.withAlpha((255 * 0.9).round()),
      900: color.withAlpha(255),
    });
  }
}
