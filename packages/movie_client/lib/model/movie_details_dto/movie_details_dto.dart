import 'dart:core';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_details_dto.freezed.dart';
part 'movie_details_dto.g.dart';

@freezed
class MovieDetailsDTO with _$MovieDetailsDTO {
  const factory MovieDetailsDTO({
    required bool? adult,
    required String? backdropPath,
    required int? budget,
    required List<Genre>? genres,
    required String? homepage,
    required int? id,
    required String? imdbId,
    required String? originalLanguage,
    required String? originalTitle,
    required String? overview,
    required double? popularity,
    required String? posterPath,
    required List<ProductionCompany>? productionCompanies,
    required List<ProductionCountry>? productionCountries,
    required String? releaseDate,
    required int? revenue,
    required int? runtime,
    required List<SpokenLanguage>? spokenLanguages,
    required String? status,
    required String? tagline,
    required String? title,
    required bool? video,
    required double? voteAverage,
    required int? voteCount,
  }) = _MovieDetailsDTO;

  factory MovieDetailsDTO.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsDTOFromJson(json);
}

@freezed
class Genre with _$Genre {
  const factory Genre({
    required int? id,
    required String? name,
  }) = _Genre;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}

@freezed
class ProductionCompany with _$ProductionCompany {
  const factory ProductionCompany({
    required int? id,
    required String? logoPath,
    required String? name,
    required String? originCountry,
  }) = _ProductionCompany;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);
}

@freezed
class ProductionCountry with _$ProductionCountry {
  const factory ProductionCountry({
    required String? iso31661,
    required String? name,
  }) = _ProductionCountry;

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);
}

@freezed
class SpokenLanguage with _$SpokenLanguage {
  const factory SpokenLanguage({
    required String? iso6391,
    required String? name,
  }) = _SpokenLanguage;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageFromJson(json);
}
