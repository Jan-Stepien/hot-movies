import 'package:mocktail/mocktail.dart';
import 'package:movie_client/model/model.dart';
import 'package:movie_client/movie_client.dart';
import 'package:movie_repository/model/movie.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class MockMovieClient extends Mock implements MovieClient {}

void main() {
  late MovieClient movieClient;
  late MovieRepository movieRepository;

  setUp(() {
    movieClient = MockMovieClient();
    movieRepository = MovieRepository(movieClient: movieClient);
  });

  const movieDTO = MovieDTO(
    posterPath: 'posterPath',
    adult: true,
    overview: 'overview',
    releaseDate: 'releaseDate',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    originalLanguage: 'originalLanguage',
    title: 'title',
    backdropPath: 'backdropPath',
    popularity: 1.0,
    voteCount: 1,
    video: true,
    voteAverage: 1.0,
  );

  group('MovieRepository', () {
    test('returns list of Movies when succeeds', () async {
      when(() => movieClient.getPopularMovies()).thenAnswer(
        (_) async => [movieDTO],
      );

      final result = await movieRepository.getPopularMovies();

      expect(result.length, 1);
      expect(
          result[0],
          const Movie(
            id: 1,
            title: 'title',
            backdropPath: 'backdropPath',
          ));

      verify(() => movieClient.getPopularMovies()).called(1);
    });
  });
}
