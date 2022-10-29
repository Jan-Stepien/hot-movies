import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_repository/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({
    required MovieRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(MovieState.initial()) {
    on<PopularMoviesRequested>(_movieLoadRequested);
  }

  final MovieRepository _movieRepository;

  FutureOr<void> _movieLoadRequested(
    PopularMoviesRequested event,
    Emitter<MovieState> emit,
  ) async {
    emit(state.copyWith(status: MovieStatus.loading));
    try {
      final movies = await _movieRepository.getPopularMovies();
      emit(state.copyWith(status: MovieStatus.finished, movies: movies));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: MovieStatus.error));
      addError(error, stackTrace);
    }
  }
}
