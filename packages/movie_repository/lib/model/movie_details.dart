import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:movie_client/model/model.dart';

class MovieDetails extends Equatable {
  final int id;
  final String title;
  final String? backdropPath;
  final String? overview;
  final double? voteAverage;

  const MovieDetails({
    required this.overview,
    required this.voteAverage,
    required this.id,
    required this.title,
    required this.backdropPath,
  });

  factory MovieDetails.fromMovieDetailsDTO(MovieDetailsDTO movieDTO) {
    return MovieDetails(
      id: movieDTO.id ?? 0,
      title: movieDTO.title ?? '',
      backdropPath: movieDTO.backdropPath,
      overview: movieDTO.overview,
      voteAverage: movieDTO.voteAverage,
    );
  }

  @override
  List<Object?> get props => [id, title, backdropPath];
}
