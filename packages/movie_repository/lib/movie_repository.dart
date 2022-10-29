library movie_client;

import 'package:movie_client/movie_client.dart';
import 'package:movie_repository/model/model.dart';

/// A [MovieRepository] responsible for managing [Movie] collection and [Movie] details.
class MovieRepository {
  MovieRepository({
    required MovieClient movieClient,
  }) : _movieClient = movieClient;

  final MovieClient _movieClient;

  /// Returns a list of popular [Movie]s.
  Future<List<Movie>> getPopularMovies() async {
    final moviesDTO = await _movieClient.getPopularMovies();

    return moviesDTO.map(Movie.fromMovieDTO).toList();
  }
}
