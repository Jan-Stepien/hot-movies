part of 'movie_details_bloc.dart';

abstract class MovieDetailsEvent extends Equatable {}

class DetailsRequested extends MovieDetailsEvent {
  @override
  List<Object?> get props => [];
}
