part of 'movie_bloc.dart';

enum MovieStatus {
  initial,
  loading,
  finished,
}

class MovieState extends Equatable {
  const MovieState._({
    required this.status,
    required this.movies,
  });

  factory MovieState.initial() => const MovieState._(
        status: MovieStatus.initial,
        movies: [],
      );

  final MovieStatus status;
  final List<Movie> movies;

  MovieState copyWith({
    MovieStatus? status,
    List<Movie>? movies,
  }) {
    return MovieState._(
      status: status ?? this.status,
      movies: movies ?? this.movies,
    );
  }

  @override
  List<Object?> get props => [status, movies];
}
