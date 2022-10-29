part of 'movie_bloc.dart';

abstract class MovieEvent {}

class PopularMoviesRequested extends MovieEvent {}

class SearchQueryChanged extends MovieEvent {
  SearchQueryChanged(this.query);

  final String query;
}
