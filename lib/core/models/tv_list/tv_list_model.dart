import 'package:json_annotation/json_annotation.dart';

import 'package:movie_colony/core/models/tv_list/tv_list.dart';

part 'tv_list_model.g.dart';

@JsonSerializable()
class TvListModel extends TvList {
  const TvListModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.date,
    required this.posterImage,
    required this.backdropImage,
    required this.overview,
  }) : super(
          id: id,
          name: name,
          rating: rating,
          date: date,
          posterImage: posterImage,
          backdropImage: backdropImage,
          overview: overview,
        );

  factory TvListModel.fromJson(Map<String, dynamic> json) =>
      _$TvListModelFromJson(json);

  final int id;
  final String name;
  @JsonKey(name: 'vote_average')
  final num rating;
  @JsonKey(name: 'first_air_date')
  final String date;
  @JsonKey(name: 'poster_path')
  final String posterImage;
  @JsonKey(name: 'backdrop_path')
  final String backdropImage;
  final String overview;

  Map<String, dynamic> toJson() => _$TvListModelToJson(this);
}
