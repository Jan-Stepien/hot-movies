import 'package:mocktail/mocktail.dart';
import 'package:movie_client/model/model.dart';
import 'package:movie_client/movie_client.dart';
import 'package:movie_repository/model/model.dart';
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

    when(() => movieClient.imageBaseUrl).thenReturn('imageBaseUrl/');
  });

  group('MovieRepository', () {
    group('getPopularMovies', () {
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
              backdropPath: 'imageBaseUrl/backdropPath',
            ));

        verify(() => movieClient.getPopularMovies()).called(1);
      });
    });

    group('getMovieDetails', () {
      const movieDetailsDto = MovieDetailsDTO(
        adult: true,
        backdropPath: 'backdropPath',
        budget: 1,
        genres: [Genre(id: 1, name: 'name')],
        homepage: 'homepage',
        id: 1,
        imdbId: 'imdbId',
        originalLanguage: 'originalLanguage',
        originalTitle: 'originalTitle',
        overview: 'overview',
        popularity: 1.0,
        posterPath: 'posterPath',
        releaseDate: 'releaseDate',
        revenue: 1,
        runtime: 1,
        status: 'status',
        tagline: 'tagline',
        title: 'title',
        video: true,
        voteAverage: 1.0,
        voteCount: 1,
        productionCompanies: [],
        productionCountries: [],
        spokenLanguages: [],
      );

      test('returns movie details when succeeds', () async {
        when(() => movieClient.getMovieDetails(id: 1)).thenAnswer(
          (_) async => movieDetailsDto,
        );

        final result = await movieRepository.getMovieDetails(id: 1);

        expect(
            result,
            const MovieDetails(
              id: 1,
              title: 'title',
              backdropPath: 'imageBaseUrl/backdropPath',
              overview: 'overview',
              voteAverage: 1.0,
            ));

        verify(() => movieClient.getMovieDetails(id: 1)).called(1);
      });
    });
  });
}
