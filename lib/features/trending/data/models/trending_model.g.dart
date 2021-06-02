// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendingModel _$TrendingModelFromJson(Map<String, dynamic> json) {
  return TrendingModel(
    id: json['id'] as int,
    name: json['name'] as String,
    rating: json['rating'] as String,
    date: json['date'] as String,
    posterImage: json['posterImage'] as String,
    backdropImage: json['backdropImage'] as String,
  );
}

Map<String, dynamic> _$TrendingModelToJson(TrendingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rating': instance.rating,
      'date': instance.date,
      'posterImage': instance.posterImage,
      'backdropImage': instance.backdropImage,
    };
