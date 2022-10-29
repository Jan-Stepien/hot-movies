import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http_client/http_client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_client/model/model.dart';
import 'package:movie_client/movie_client.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late HttpClient httpClient;
  late MovieClient movieClient;

  setUp(() {
    httpClient = MockHttpClient();
    movieClient = MovieClient(
      httpClient: httpClient,
      apiKey: 'apiKey',
      baseUrl: 'baseUrl',
    );
  });

  registerFallbackValue(Uri());

  group('MovieClient', () {
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

      test(
          'returns list of movies '
          'when httpCall succeeds', () async {
        when(() => httpClient.get(any())).thenAnswer(
          (invocation) => Future.value(
            Response(
              jsonEncode({
                'results': [movieDTO.toJson()],
              }),
              HttpStatus.ok,
            ),
          ),
        );

        final result = await movieClient.getPopularMovies();

        expect(result, [movieDTO]);
        verify(() => httpClient.get(any())).called(1);
      });

      test(
          'throws GetPopularMoviesException '
          'when response.body malformed', () async {
        when(() => httpClient.get(any())).thenAnswer(
          (invocation) async => Response('malformedBody', HttpStatus.ok),
        );

        expect(movieClient.getPopularMovies(),
            throwsA(isA<GetPopularMoviesException>()));
        verify(() => httpClient.get(any())).called(1);
      });

      test(
          'throws GetPopularMoviesNetworkException '
          'when response.statusCode is not HttpStatus.ok', () async {
        when(() => httpClient.get(any())).thenAnswer(
          (invocation) async =>
              Response(jsonEncode([movieDTO]), HttpStatus.badRequest),
        );

        expect(movieClient.getPopularMovies(),
            throwsA(isA<GetPopularMoviesNetworkException>()));
        verify(() => httpClient.get(any())).called(1);
      });
    });

    group('getMovieDetails', () {
      const movieDetailsDTO = MovieDetailsDTO(
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
        productionCompanies: [
          ProductionCompany(
              id: 1,
              logoPath: 'logoPath',
              name: 'name',
              originCountry: 'originCountry')
        ],
        productionCountries: [
          ProductionCountry(iso31661: 'iso31661', name: 'name')
        ],
        releaseDate: 'releaseDate',
        revenue: 1,
        runtime: 1,
        spokenLanguages: [SpokenLanguage(iso6391: 'iso6391', name: 'name')],
        status: 'status',
        tagline: 'tagline',
        title: 'title',
        video: true,
        voteAverage: 1.0,
        voteCount: 1,
      );

      test(
          'returns movie details '
          'when httpCall succeeds', () async {
        when(() => httpClient.get(any())).thenAnswer(
          (invocation) async =>
              Response(jsonEncode(movieDetailsDTO), HttpStatus.ok),
        );

        final result = await movieClient.getMovieDetails(id: 1);

        expect(result, movieDetailsDTO);
        verify(() => httpClient.get(any())).called(1);
      });

      test(
          'throws GetMovieDetailsException '
          'when response.body malformed', () async {
        when(() => httpClient.get(any())).thenAnswer(
          (invocation) async => Response('malformedBody', HttpStatus.ok),
        );

        expect(movieClient.getMovieDetails(id: 1),
            throwsA(isA<GetMovieDetailsException>()));
        verify(() => httpClient.get(any())).called(1);
      });

      test(
          'throws GetMovieDetailsNetworkException '
          'when response.statusCode is not HttpStatus.ok', () async {
        when(() => httpClient.get(any())).thenAnswer(
          (invocation) async =>
              Response(jsonEncode(movieDetailsDTO), HttpStatus.badRequest),
        );

        expect(movieClient.getMovieDetails(id: 1),
            throwsA(isA<GetMovieDetailsNetworkException>()));
      });
    });
  });
}
