library movie_client;

import 'dart:convert';
import 'dart:io';

import 'package:http_client/http_client.dart';
import 'package:movie_client/model/model.dart';

export 'model/model.dart';

/// [MovieClient] is a class that provides access to the Movie API.
class MovieClient {
  MovieClient({
    required HttpClient httpClient,
    required String apiKey,
  })  : _httpClient = httpClient,
        _apiKey = apiKey,
        _baseUrl = 'https://api.themoviedb.org/3',
        _imageBaseUrl = 'https://image.tmdb.org/t/p/original/';

  final HttpClient _httpClient;
  final String _apiKey;
  final String _baseUrl;
  final String _imageBaseUrl;

  String get imageBaseUrl => _imageBaseUrl;
  Map<String, String> get getApiKeyQueryParameter => {'api_key': _apiKey};

  static const basePath = '/movie/';

  /// [getPopularMovies] returns a list of popular movies.
  Future<List<MovieDTO>> getPopularMovies({int page = 1}) async {
    const getPopularMoviesPath = 'popular';

    final uri = Uri.parse(_baseUrl + basePath + getPopularMoviesPath).replace(
        queryParameters: getApiKeyQueryParameter
          ..addAll({'page': page.toString()}));

    try {
      final response = await _httpClient.get(uri);

      if (response.statusCode == HttpStatus.ok) {
        return _parseMovieListResponse(response.body);
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

  /// [getMovieDetails] returns a [MovieDetailsDTO] for given [id].
  Future<MovieDetailsDTO> getMovieDetails({required int id}) async {
    final uri = Uri.parse(_baseUrl + basePath + id.toString())
        .replace(queryParameters: getApiKeyQueryParameter);

    try {
      final response = await _httpClient.get(uri);

      if (response.statusCode == HttpStatus.ok) {
        final movieDetailsJson = jsonDecode(response.body);
        return MovieDetailsDTO.fromJson(movieDetailsJson);
      } else {
        throw GetMovieDetailsNetworkException(
          statusCode: response.statusCode,
          body: response.body,
        );
      }
    } on GetMovieDetailsNetworkException {
      rethrow;
    } catch (error, stackTrace) {
      throw GetMovieDetailsException(error, stackTrace);
    }
  }

  /// [searchMovies] returns a list of [MovieDTO] containing [query].
  Future<List<MovieDTO>> searchMovies(
      {required String query, int page = 1}) async {
    const searchMoviesPath = '/search/movie';

    final uri = Uri.parse(_baseUrl + searchMoviesPath).replace(
        queryParameters: getApiKeyQueryParameter
          ..addAll({'query': query, 'page': page.toString()}));

    try {
      final response = await _httpClient.get(uri);

      if (response.statusCode == HttpStatus.ok) {
        return _parseMovieListResponse(response.body);
      } else {
        throw SearchMoviesNetworkException(
          statusCode: response.statusCode,
          body: response.body,
        );
      }
    } on SearchMoviesNetworkException {
      rethrow;
    } catch (error, stackTrace) {
      throw SearchMoviesException(error, stackTrace);
    }
  }

  /// Parses response to list of [MovieDTO]
  List<MovieDTO> _parseMovieListResponse(String response) {
    final resultList = jsonDecode(response)["results"] as List;
    return resultList.map((movieJson) => MovieDTO.fromJson(movieJson)).toList();
  }
}
