import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'genre_model.freezed.dart';
part 'genre_model.g.dart';

GenreModel genreModelFromJson(String str) =>
    GenreModel.fromJson(json.decode(str) as Map<String, dynamic>);

String genreModelToJson(GenreModel data) => json.encode(data.toJson());

@freezed
class GenreModel with _$GenreModel {
  const factory GenreModel({
    List<Genre>? genres,
  }) = _GenreModel;

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);
}

@freezed
class Genre with _$Genre {
  const factory Genre({
    int? id,
    String? name,
  }) = _Genre;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}
