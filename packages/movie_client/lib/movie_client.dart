library movie_client;

import 'dart:convert';
import 'dart:io';

import 'package:http_client/http_client.dart';
import 'package:movie_client/model/model.dart';

/// [MovieClient] is a class that provides access to the Movie API.
class MovieClient {
  MovieClient({
    required HttpClient httpClient,
    required String apiKey,
    required String baseUrl,
  })  : _httpClient = httpClient,
        _apiKey = apiKey,
        _baseUrl = 'https://api.themoviedb.org/3',
        _imageBaseUrl = 'https://image.tmdb.org/t/p/original/';

  final HttpClient _httpClient;
  final String _apiKey;
  final String _baseUrl;
  final String _imageBaseUrl;

  String get baseUrl => _baseUrl;
  String get imageBaseUrl => _imageBaseUrl;
  Map<String, String> get getApiKeyQueryParameter => {'api_key': _apiKey};

  static const basePath = '/movie';

  /// [getPopularMovies] returns a list of popular movies.
  Future<List<MovieDTO>> getPopularMovies() async {
    const getPopularMoviesPath = '/popular';

    final uri = Uri.parse(_baseUrl + basePath + getPopularMoviesPath)
        .replace(queryParameters: getApiKeyQueryParameter);

    try {
      final response = await _httpClient.get(uri);

      if (response.statusCode == HttpStatus.ok) {
        final resultList = jsonDecode(response.body)["results"] as List;
        return resultList
            .map((movieJson) => MovieDTO.fromJson(movieJson))
            .toList();
      } else {
        throw GetPopularMoviesNetworkException(
          statusCode: response.statusCode,
          body: response.body,
        );
      }
    } on GetPopularMoviesNetworkException {
      rethrow;
    } catch (error, stackTrace) {
      throw GetPopularMoviesException(error, stackTrace);
    }
  }
}
