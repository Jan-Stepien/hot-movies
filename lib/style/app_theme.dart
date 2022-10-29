import 'package:flutter/material.dart';
import 'package:hot_movies/style/style.dart';

class AppTheme {
  ThemeData get themeData => ThemeData(
        colorScheme: _colorScheme,
        listTileTheme: _listTileTheme,
      );

  ColorScheme get _colorScheme => const ColorScheme(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,

        // TODO(jan-stepien): The following colors should be replaced with the correct colors.
        secondary: AppColors.primary,
        onSecondary: AppColors.onPrimary,
        error: AppColors.primary,
        onError: AppColors.onPrimary,
        background: AppColors.onPrimary,
        onBackground: AppColors.primary,
        surface: AppColors.onPrimary,
        onSurface: AppColors.primary,
        brightness: Brightness.light,
      );
  ListTileThemeData get _listTileTheme => const ListTileThemeData(
        iconColor: AppColors.listTileIconColor,
      );
}
