import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/categories.dart';

part 'categories_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class CategoriesModel extends Categories {
  CategoriesModel(this.id, this.name) : super(id: id, name: name);

  int id;
  String name;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesModelToJson(this);
}
