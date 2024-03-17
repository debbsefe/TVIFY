import 'package:json_annotation/json_annotation.dart';

import 'package:movie_colony/features/categories/domain/entities/categories.dart';

part 'categories_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class CategoriesModel extends Categories {
  CategoriesModel({required this.id, required this.name})
      : super(id: id, name: name);

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);

  int id;
  String name;

  Map<String, dynamic> toJson() => _$CategoriesModelToJson(this);
}
