import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_constants.dart';

const ColorScheme darkColorScheme = ColorScheme.dark(
  surface: TextColor.lightBlack,
  primary: TextColor.lightBlack,
  secondary: TextColor.lightBlack,
  tertiary: TextColor.lightBlack,
  inversePrimary: TextColor.lightBlack,
  primaryFixed: TextColor.lightBlack,
  primaryFixedDim: TextColor.lightBlack,
  secondaryFixed: TextColor.lightBlack,
  tertiaryFixed: TextColor.lightBlack,
);

ThemeData darkMode = ThemeData(
  fontFamily: GoogleFonts.comfortaa().fontFamily,
  colorScheme: ColorScheme.dark(
    surface: darkColorScheme.surface,
    primary: darkColorScheme.primary,
    secondary: darkColorScheme.secondary,
    tertiary: darkColorScheme.tertiary,
    inversePrimary: darkColorScheme.inversePrimary,
    primaryFixed: darkColorScheme.primaryFixed,
    primaryFixedDim: darkColorScheme.primaryFixedDim,
    secondaryFixed: darkColorScheme.secondaryFixed,
    secondaryFixedDim: darkColorScheme.secondaryFixedDim,
    tertiaryFixed: darkColorScheme.tertiaryFixed,
  ),
  // cardColor: BackgroundColor.greyCard,
  scaffoldBackgroundColor: BackgroundColor.cream,
  textTheme: Typography.material2021().white.copyWith(
    titleLarge: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily),
    titleMedium: TextStyle(
      // fontSize: 36, //done // don't change
      fontFamily: GoogleFonts.comfortaa().fontFamily,
    ),
    titleSmall: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily),
    headlineLarge: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily),
    headlineMedium: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily),
    headlineSmall: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily),
    bodyLarge: TextStyle(
      // fontSize: 18, // done // don't change
      fontFamily: GoogleFonts.comfortaa().fontFamily,
    ),
    bodyMedium: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily),
    bodySmall: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily),
    labelLarge: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily),
    labelMedium: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily),
    labelSmall: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily),
    displayLarge: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily),
    displayMedium: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily),
    displaySmall: TextStyle(fontFamily: GoogleFonts.comfortaa().fontFamily),
  ),
  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(color: darkColorScheme.primary, fontSize: 24),
  ),
  inputDecorationTheme: InputDecorationTheme(
    errorStyle: TextStyle(color: ErrorColor.red, fontSize: 12),
    errorMaxLines: 4,
    fillColor: BackgroundColor.cream,
    contentPadding: EdgeInsets.all(10),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: BorderColor.brown, width: 0.5),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: BorderColor.brown, width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: BorderColor.brown),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: ErrorColor.red),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: ErrorColor.red),
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);
