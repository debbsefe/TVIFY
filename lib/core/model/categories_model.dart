import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories_model.freezed.dart';
part 'categories_model.g.dart';

CategoriesModel categoriesModelFromJson(String str) =>
    CategoriesModel.fromJson(json.decode(str) as Map<String, dynamic>);

String categoriesModelToJson(CategoriesModel data) =>
    json.encode(data.toJson());

@freezed
class CategoriesModel with _$CategoriesModel {
  const factory CategoriesModel({
    List<Genre>? genres,
  }) = _CategoriesModel;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);
}

@freezed
class Genre with _$Genre {
  const factory Genre({
    int? id,
    String? name,
  }) = _Genre;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}
