import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_movies/shared/event_transformer.dart';
import 'package:movie_repository/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

const _duration = Duration(milliseconds: 300);

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({
    required MovieRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(MovieState.initial()) {
    on<PopularMoviesRequested>(_popularMoviesRequested);
    on<SearchQueryChanged>(
      _searchQueryChanged,
      transformer: restartableDebounce(
        _duration,
      ),
    );
    on<LoadMoreMoviesRequested>(
      _loadMoreMoviesRequested,
      transformer: restartable(),
    );
  }

  final MovieRepository _movieRepository;

  FutureOr<void> _popularMoviesRequested(
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

  FutureOr<void> _searchQueryChanged(
    SearchQueryChanged event,
    Emitter<MovieState> emit,
  ) async {
    emit(
      state.copyWith(
        status: MovieStatus.loading,
        query: event.query,
        page: 1,
      ),
    );
    try {
      List<Movie> movies;
      if (event.query.isEmpty) {
        movies = await _movieRepository.getPopularMovies();
      } else {
        movies = await _movieRepository.searchMovies(query: event.query);
      }
      emit(
        state.copyWith(
          status: MovieStatus.finished,
          movies: movies,
        ),
      );
    } catch (error, stackTrace) {
      emit(
        state.copyWith(
          status: MovieStatus.error,
        ),
      );
      addError(error, stackTrace);
    }
  }

  FutureOr<void> _loadMoreMoviesRequested(
    LoadMoreMoviesRequested event,
    Emitter<MovieState> emit,
  ) async {
    try {
      List<Movie> movies;
      if (state.query.isEmpty) {
        movies = await _movieRepository.getPopularMovies(page: state.page + 1);
      } else {
        movies = await _movieRepository.searchMovies(
          query: state.query,
          page: state.page + 1,
        );
      }
      emit(
        state.copyWith(
          status: MovieStatus.finished,
          movies: [
            ...state.movies,
            ...movies,
          ],
          page: state.page + 1,
        ),
      );
    } catch (error, stackTrace) {
      emit(state.copyWith(status: MovieStatus.error));
      addError(error, stackTrace);
    }
  }
}
