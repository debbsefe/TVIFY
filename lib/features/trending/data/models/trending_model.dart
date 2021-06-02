import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/trending.dart';

part 'trending_model.g.dart';

@JsonSerializable()
class TrendingModel extends Trending {
  const TrendingModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.date,
    required this.posterImage,
    required this.backdropImage,
  }) : super(
          id: id,
          name: name,
          rating: rating,
          date: date,
          posterImage: posterImage,
          backdropImage: backdropImage,
        );

  factory TrendingModel.fromJson(Map<String, dynamic> json) =>
      _$TrendingModelFromJson(json);

  final int id;
  final String name;
  final String rating;
  final String date;
  final String posterImage;
  final String backdropImage;

  Map<String, dynamic> toJson() => _$TrendingModelToJson(this);
}
