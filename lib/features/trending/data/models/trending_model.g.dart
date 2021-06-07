// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendingModel _$TrendingModelFromJson(Map<String, dynamic> json) {
  return TrendingModel(
    id: json['id'] as int,
    name: json['name'] as String,
    rating: json['vote_average'] as num,
    date: json['first_air_date'] as String,
    posterImage: json['poster_path'] as String,
    backdropImage: json['backdrop_path'] as String,
    overview: json['overview'] as String,
  );
}

Map<String, dynamic> _$TrendingModelToJson(TrendingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'vote_average': instance.rating,
      'first_air_date': instance.date,
      'poster_path': instance.posterImage,
      'backdrop_path': instance.backdropImage,
      'overview': instance.overview,
    };
