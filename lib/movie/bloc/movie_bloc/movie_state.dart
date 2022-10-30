part of 'movie_bloc.dart';

enum MovieStatus {
  initial,
  loading,
  error,
  finished,
}

class MovieState extends Equatable {
  const MovieState._({
    required this.query,
    required this.page,
    required this.status,
    required this.movies,
  });

  factory MovieState.initial() => const MovieState._(
        query: '',
        page: 1,
        status: MovieStatus.initial,
        movies: [],
      );

  final MovieStatus status;
  final int page;
  final String query;
  final List<Movie> movies;

  MovieState copyWith({
    String? query,
    int? page,
    MovieStatus? status,
    List<Movie>? movies,
  }) {
    return MovieState._(
      query: query ?? this.query,
      page: page ?? this.page,
      status: status ?? this.status,
      movies: movies ?? this.movies,
    );
  }

  @override
  List<Object?> get props => [status, movies, page, query];
}
