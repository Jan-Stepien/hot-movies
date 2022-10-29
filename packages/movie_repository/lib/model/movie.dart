import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:movie_client/model/model.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String? backdropPath;

  const Movie({
    required this.id,
    required this.title,
    required this.backdropPath,
  });

  factory Movie.fromMovieDTO(MovieDTO movieDTO) {
    return Movie(
      id: movieDTO.id ?? 0,
      title: movieDTO.title ?? '',
      backdropPath: movieDTO.backdropPath,
    );
  }

  @override
  List<Object?> get props => [id, title, backdropPath];
}
