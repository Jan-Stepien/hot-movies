import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hot_movies/movie/movie.dart';

import '../../helpers/helpers.dart';

void main() {
  group('ScoreBadge', () {
    testWidgets('renders Text and CircularProgressIndicator', (tester) async {
      await tester.pumpApp(const ScoreBadge(score: 0.5, size: 50));
      expect(find.byType(Stack), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders Text with score', (tester) async {
      await tester.pumpApp(const ScoreBadge(score: 5, size: 50));
      expect(find.text('50%'), findsOneWidget);
    });

    group('rounds score', () {
      testWidgets('up when half', (tester) async {
        await tester.pumpApp(const ScoreBadge(score: 5.55, size: 50));
        expect(find.text('56%'), findsOneWidget);
      });
      testWidgets('down when less than half', (tester) async {
        await tester.pumpApp(const ScoreBadge(score: 5.54, size: 50));
        expect(find.text('55%'), findsOneWidget);
      });
    });
  });
}
