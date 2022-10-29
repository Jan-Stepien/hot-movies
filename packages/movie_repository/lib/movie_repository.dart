library movie_client;

import 'package:movie_client/movie_client.dart';
import 'package:movie_repository/model/model.dart';

export 'model/model.dart';

/// A [MovieRepository] responsible for managing [Movie] collection and [Movie] details.
class MovieRepository {
  MovieRepository({
    required MovieClient movieClient,
  }) : _movieClient = movieClient;

  final MovieClient _movieClient;

  /// Returns a list of popular [Movie]s.
  Future<List<Movie>> getPopularMovies() async {
    final moviesDTO = await _movieClient.getPopularMovies();

    return _mapMovieDTOListToMovieList(moviesDTO: moviesDTO);
  }

  /// Returns a [MovieDetails] for given [id].
  Future<MovieDetails> getMovieDetails({required int id}) async {
    final movieDetailsDTO = await _movieClient.getMovieDetails(id: id);

    final imageBaseUrl = _movieClient.imageBaseUrl;

    return MovieDetails.fromMovieDetailsDTO(
      movieDetailsDTO.copyWith(
        backdropPath: movieDetailsDTO.backdropPath != null
            ? '$imageBaseUrl${movieDetailsDTO.backdropPath}'
            : null,
      ),
    );
  }

  /// Returns a list of [Movie] containing [query].
  Future<List<Movie>> searchMovies({required String query}) async {
    final moviesDTO = await _movieClient.searchMovies(query: query);

    return _mapMovieDTOListToMovieList(moviesDTO: moviesDTO);
  }

  /// Maps list of [MovieDTO] to list of [Movie].
  List<Movie> _mapMovieDTOListToMovieList({required List<MovieDTO> moviesDTO}) {
    final imageBaseUrl = _movieClient.imageBaseUrl;

    return moviesDTO
        .map(
          (item) => Movie.fromMovieDTO(
            item.copyWith(
              backdropPath: item.backdropPath != null
                  ? '$imageBaseUrl${item.backdropPath}'
                  : null,
            ),
          ),
        )
        .toList();
  }
}
