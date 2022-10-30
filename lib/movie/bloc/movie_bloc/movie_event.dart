part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {}

class PopularMoviesRequested extends MovieEvent {
  @override
  List<Object?> get props => [];
}

class SearchQueryChanged extends MovieEvent {
  SearchQueryChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}
