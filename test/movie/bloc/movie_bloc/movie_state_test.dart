import 'package:flutter_test/flutter_test.dart';
import 'package:hot_movies/movie/movie.dart';
import 'package:movie_repository/movie_repository.dart';

void main() {
  group('MovieState', () {
    test('supports value comparisons', () {
      expect(
        MovieState.initial(),
        equals(MovieState.initial()),
      );
    });

    group('copyWith updates', () {
      test('status', () {
        final status =
            MovieState.initial().copyWith(status: MovieStatus.error).status;
        expect(status, equals(MovieStatus.error));
      });

      test('movies', () {
        const movie =
            Movie(id: 1, title: 'title', backdropPath: 'backdropPath');
        final movies = MovieState.initial().copyWith(movies: [movie]).movies;
        expect(movies, equals([movie]));
      });
    });
  });
}
