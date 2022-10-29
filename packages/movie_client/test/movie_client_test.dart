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

  const movie = MovieDTO(
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

  registerFallbackValue(Uri());

  group('MovieClient', () {
    group('getPopularMovies', () {
      test(
          'returns list of movies '
          'when httpCall succeeds', () async {
        when(() => httpClient.get(any())).thenAnswer(
          (invocation) async => Response(jsonEncode([movie]), 200),
        );

        final result = await movieClient.getPopularMovies();

        expect(result, [movie]);
        verify(() => httpClient.get(any())).called(1);
      });

      test(
          'throws GetPopularMoviesException '
          'when response.body malformed', () async {
        when(() => httpClient.get(any())).thenAnswer(
          (invocation) async => Response('malformedBody', 200),
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
              Response(jsonEncode([movie]), HttpStatus.badRequest),
        );

        expect(movieClient.getPopularMovies(),
            throwsA(isA<GetPopularMoviesNetworkException>()));
        verify(() => httpClient.get(any())).called(1);
      });
    });
  });
}
