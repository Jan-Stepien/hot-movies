import 'package:flutter_test/flutter_test.dart';
import 'package:hot_movies/movie/movie.dart';

void main() {
  group('MovieEvent', () {
    test('PopularMoviesRequested supports value comparisons', () {
      expect(
        PopularMoviesRequested(),
        equals(PopularMoviesRequested()),
      );
    });

    test('SearchQueryChanged supports value comparisons', () {
      expect(
        SearchQueryChanged('query'),
        equals(SearchQueryChanged('query')),
      );
    });
  });
}
