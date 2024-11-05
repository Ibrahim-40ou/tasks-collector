import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: AppColors.backgroundLight,
    primary: AppColors.primaryLight,
    onPrimary: Colors.white,
    secondary: AppColors.secondaryLight,
    onSecondary: Colors.white,
    tertiary: AppColors.accentLight,
    onTertiary: Colors.white,
    error: AppColors.error,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: AppColors.textLight,
    ),
    labelMedium: TextStyle(
      color: AppColors.greyLight,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryLight,
    ),
  ),
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.light(
    brightness: Brightness.dark,
    surface: AppColors.backgroundDark,
    primary: AppColors.primaryDark,
    onPrimary: Colors.white,
    secondary: AppColors.secondaryDark,
    onSecondary: Colors.white,
    tertiary: AppColors.accentDark,
    onTertiary: Colors.white,
    error: AppColors.error,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: AppColors.textDark,
    ),
    labelMedium: TextStyle(
      color: AppColors.greyDark,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryDark,
    ),
  ),
);
