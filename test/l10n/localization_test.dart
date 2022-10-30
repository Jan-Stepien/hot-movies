import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hot_movies/l10n/l10n.dart';

import '../helpers/helpers.dart';

void main() {
  group('LocalizationExtension', () {
    testWidgets('performs localizations lookup', (tester) async {
      await tester.pumpApp(
        Builder(
          builder: (context) => Text(context.l10n.refresh),
        ),
      );
      expect(find.text('Refresh'), findsOneWidget);
    });
  });
}
