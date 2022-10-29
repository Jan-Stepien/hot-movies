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
