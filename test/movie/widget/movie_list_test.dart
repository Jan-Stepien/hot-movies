import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hot_movies/movie/movie.dart';
import 'package:movie_repository/movie_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  final movies = [
    const Movie(id: 1, title: 'title', backdropPath: 'backdropPath'),
    const Movie(id: 2, title: 'title', backdropPath: 'backdropPath'),
  ];
  group('MovieList', () {
    testWidgets('renders ListTiles equal to movies.count', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: MovieList(
            movies: movies,
            onLoadMore: () {},
          ),
        ),
      );

      expect(find.byType(ListTile), findsNWidgets(movies.length));
    });

    testWidgets('when ListTile is tapped, navigates to MovieDetailsPage',
        (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: MovieList(
            movies: movies,
            onLoadMore: () {},
          ),
        ),
      );

      await tester.tap(find.byType(ListTile).first);
      await tester.pumpAndSettle();

      expect(find.byType(MovieDetailsPage), findsOneWidget);
    });

    testWidgets(
        'when scrolled 300 from bottom of screen, '
        'onLoadMore is called', (tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 100));

      final completer = Completer<void>();

      await tester.pumpApp(
        Scaffold(
          body: MovieList(
            movies: movies,
            onLoadMore: completer.complete,
          ),
        ),
      );

      await tester.drag(
        find.byKey(
          const Key('movie_list_scroll_view'),
        ),
        const Offset(0, -100),
      );

      await tester.pumpAndSettle();

      expect(completer.isCompleted, isTrue);
      await tester.binding.setSurfaceSize(null);
    });
  });
}
