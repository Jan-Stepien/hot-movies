part of 'movie_details_bloc.dart';

enum MovieDetailsStatus {
  initial,
  loading,
  error,
  finished,
}

class MovieDetailsState extends Equatable {
  const MovieDetailsState._({
    required this.status,
    required this.id,
    required this.details,
  });

  factory MovieDetailsState.initial({required int id}) => MovieDetailsState._(
        status: MovieDetailsStatus.initial,
        id: id,
        details: null,
      );

  final MovieDetailsStatus status;
  final int id;
  final MovieDetails? details;

  MovieDetailsState copyWith({
    MovieDetailsStatus? status,
    MovieDetails? details,
  }) {
    return MovieDetailsState._(
      id: id,
      status: status ?? this.status,
      details: details ?? this.details,
    );
  }

  @override
  List<Object?> get props => [status, id, details];
}
