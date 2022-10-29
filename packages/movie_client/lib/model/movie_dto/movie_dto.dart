import 'dart:core';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_dto.freezed.dart';
part 'movie_dto.g.dart';

@freezed
class MovieDTO with _$MovieDTO {
  const factory MovieDTO({
    required String posterPath,
    required bool adult,
    required String overview,
    required String releaseDate,
    required List<int> genreIds,
    required int id,
    required String originalTitle,
    required String originalLanguage,
    required String title,
    required String backdropPath,
    required double popularity,
    required int voteCount,
    required bool video,
    required double voteAverage,
  }) = _MovieDTO;

  factory MovieDTO.fromJson(Map<String, dynamic> json) =>
      _$MovieDTOFromJson(json);
}
