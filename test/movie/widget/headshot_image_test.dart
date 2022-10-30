import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hot_movies/movie/movie.dart';

import '../../helpers/helpers.dart';

void main() {
  group('HeadshotImage', () {
    testWidgets('renders Image when imageUrl is not null', (tester) async {
      await tester.pumpApp(const HeadshotImage(imageUrl: 'imageUrl'));

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });
    testWidgets('renders SizedBox when imageUrl is null', (tester) async {
      await tester.pumpApp(const HeadshotImage(imageUrl: null));

      expect(find.byType(CachedNetworkImage), findsNothing);
      final sizedbox = find.descendant(
        of: find.byType(HeadshotImage),
        matching: find.byType(SizedBox),
      );

      expect(sizedbox, findsOneWidget);
    });
  });
}
