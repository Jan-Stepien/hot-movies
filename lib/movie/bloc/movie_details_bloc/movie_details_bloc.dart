import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_repository/movie_repository.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc({
    required int id,
    required MovieRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(MovieDetailsState.initial(id: id)) {
    on<DetailsRequested>(_detailsRequested);
  }

  final MovieRepository _movieRepository;

  FutureOr<void> _detailsRequested(
    DetailsRequested event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(state.copyWith(status: MovieDetailsStatus.loading));
    try {
      final details = await _movieRepository.getMovieDetails(id: state.id);
      emit(
        state.copyWith(
          status: MovieDetailsStatus.finished,
          details: details,
        ),
      );
    } catch (error, stackTrace) {
      emit(state.copyWith(status: MovieDetailsStatus.error));
      addError(error, stackTrace);
    }
  }
}
