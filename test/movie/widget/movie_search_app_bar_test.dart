import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hot_movies/movie/widget/movie_search_app_bar.dart';

import '../../helpers/helpers.dart';

void main() {
  group('MovieSearchAppBar', () {
    test('implements PreferredSizeWidget', () {
      expect(
        MovieSearchAppBar(onSearchQueryChanged: (_) {}),
        isA<PreferredSizeWidget>(),
      );
    });

    testWidgets('after search button clicked, shows TextField ',
        (tester) async {
      await tester.pumpApp(
        Scaffold(
          appBar: MovieSearchAppBar(onSearchQueryChanged: (_) {}),
        ),
      );

      expect(find.byType(TextField), findsNothing);

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('when TextField changed, triggers onSearchQueryChanged ',
        (tester) async {
      final completer = Completer<String>();
      await tester.pumpApp(
        Scaffold(
          appBar: MovieSearchAppBar(onSearchQueryChanged: completer.complete),
        ),
      );
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'query');
      await tester.pumpAndSettle();

      expect(completer.future, completion('query'));
    });

    testWidgets(
        'when close button clicked and textfield is empty, '
        'hides TextField', (tester) async {
      final completer = Completer<String>();
      await tester.pumpApp(
        Scaffold(
          appBar: MovieSearchAppBar(onSearchQueryChanged: completer.complete),
        ),
      );
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsNothing);
      expect(completer.isCompleted, isFalse);
    });

    testWidgets(
        'when close button clicked and textfield is not empty, '
        'clears TextField and calls onSearchQueryChanged', (tester) async {
      final resultList = <String>[];
      await tester.pumpApp(
        Scaffold(
          appBar: MovieSearchAppBar(onSearchQueryChanged: resultList.add),
        ),
      );
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'query');

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(resultList, ['query', '']);
    });
  });
}
