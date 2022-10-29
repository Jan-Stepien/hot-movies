abstract class MovieClientException implements Exception {}

class GetPopularMoviesException implements MovieClientException {
  GetPopularMoviesException(this.error, this.stackTrace);

  Object? error;
  Object? stackTrace;
}

class GetPopularMoviesNetworkException implements MovieClientException {
  const GetPopularMoviesNetworkException({required this.statusCode, this.body});

  final int statusCode;
  final String? body;
}

class GetMovieDetailsException implements MovieClientException {
  GetMovieDetailsException(this.error, this.stackTrace);

  Object? error;
  Object? stackTrace;
}

class GetMovieDetailsNetworkException implements MovieClientException {
  const GetMovieDetailsNetworkException({required this.statusCode, this.body});

  final int statusCode;
  final String? body;
}

class SearchMoviesException implements MovieClientException {
  SearchMoviesException(this.error, this.stackTrace);

  Object? error;
  Object? stackTrace;
}

class SearchMoviesNetworkException implements MovieClientException {
  const SearchMoviesNetworkException({required this.statusCode, this.body});

  final int statusCode;
  final String? body;
}
