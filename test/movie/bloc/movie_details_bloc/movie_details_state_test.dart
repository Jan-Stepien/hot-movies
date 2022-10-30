import 'package:flutter_test/flutter_test.dart';
import 'package:hot_movies/movie/movie.dart';
import 'package:movie_repository/movie_repository.dart';

void main() {
  group('MovieDetailsState', () {
    test('supports value comparisons', () {
      expect(
        MovieDetailsState.initial(id: 1),
        MovieDetailsState.initial(id: 1),
      );
    });

    group('copyWith updates', () {
      test('status', () {
        final status = MovieDetailsState.initial(id: 1)
            .copyWith(status: MovieDetailsStatus.loading)
            .status;
        expect(
          status,
          equals(MovieDetailsStatus.loading),
        );
      });

      test('details', () {
        const movieDetails = MovieDetails(
          id: 1,
          overview: 'overview',
          voteAverage: 1,
          title: 'title',
          backdropPath: 'backdropPath',
        );

        final details = MovieDetailsState.initial(id: 1)
            .copyWith(
              details: movieDetails,
            )
            .details;

        expect(
          details,
          equals(
            movieDetails,
          ),
        );
      });
    });
  });
}
