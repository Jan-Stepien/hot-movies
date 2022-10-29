// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MovieDTO _$$_MovieDTOFromJson(Map<String, dynamic> json) => _$_MovieDTO(
      posterPath: json['posterPath'] as String,
      adult: json['adult'] as bool,
      overview: json['overview'] as String,
      releaseDate: json['releaseDate'] as String,
      genreIds:
          (json['genreIds'] as List<dynamic>).map((e) => e as int).toList(),
      id: json['id'] as int,
      originalTitle: json['originalTitle'] as String,
      originalLanguage: json['originalLanguage'] as String,
      title: json['title'] as String,
      backdropPath: json['backdropPath'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      voteCount: json['voteCount'] as int,
      video: json['video'] as bool,
      voteAverage: (json['voteAverage'] as num).toDouble(),
    );

Map<String, dynamic> _$$_MovieDTOToJson(_$_MovieDTO instance) =>
    <String, dynamic>{
      'posterPath': instance.posterPath,
      'adult': instance.adult,
      'overview': instance.overview,
      'releaseDate': instance.releaseDate,
      'genreIds': instance.genreIds,
      'id': instance.id,
      'originalTitle': instance.originalTitle,
      'originalLanguage': instance.originalLanguage,
      'title': instance.title,
      'backdropPath': instance.backdropPath,
      'popularity': instance.popularity,
      'voteCount': instance.voteCount,
      'video': instance.video,
      'voteAverage': instance.voteAverage,
    };
