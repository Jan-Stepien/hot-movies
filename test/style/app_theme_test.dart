import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hot_movies/style/style.dart';

void main() {
  group('AppTheme', () {
    group('sets color', () {
      test('primary to oxfordBlue', () {
        expect(
          AppTheme().themeData.colorScheme.primary,
          const Color(0xFF042541),
        );
      });
      test('onPrimary to white', () {
        expect(
          AppTheme().themeData.colorScheme.onPrimary,
          const Color(0xFFFFFFFF),
        );
      });
    });
    test('sets ListTileThemeData.iconColor to chineeseWhite', () {
      expect(
        AppTheme().themeData.listTileTheme.iconColor,
        const Color(0xFFE0E0E0),
      );
    });
    test('sets TextTheme bodyText2 height to 1.75', () {
      expect(
        AppTheme().themeData.textTheme.bodyText2?.height,
        1.75,
      );
    });
  });
}
