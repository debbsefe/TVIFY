// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tv_list_model.freezed.dart';
part 'tv_list_model.g.dart';

TvListModel tvListModelFromJson(String str) =>
    TvListModel.fromJson(json.decode(str) as Map<String, dynamic>);

String tvListModelToJson(TvListModel data) => json.encode(data.toJson());

@freezed
class TvListModel with _$TvListModel {
  const factory TvListModel({
    int? page,
    List<Result>? results,
    @JsonKey(name: 'total_pages') int? totalPages,
    @JsonKey(name: 'total_results') int? totalResults,
  }) = _TvListModel;

  factory TvListModel.fromJson(Map<String, dynamic> json) =>
      _$TvListModelFromJson(json);
}

@freezed
class Result with _$Result {
  const factory Result({
    bool? adult,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    int? id,
    String? name,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'original_name') String? originalName,
    String? overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'media_type') String? mediaType,
    @JsonKey(name: 'genre_ids') List<int>? genreIds,
    double? popularity,
    @JsonKey(name: 'first_air_date') String? firstAirDate,
    @JsonKey(name: 'vote_average') double? voteAverage,
    @JsonKey(name: 'vote_count') int? voteCount,
    @JsonKey(name: 'origin_country') List<String>? originCountry,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
