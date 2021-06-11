import 'package:json_annotation/json_annotation.dart';

import 'movie_list.dart';

part 'movie_list_model.g.dart';

@JsonSerializable()
class MovieListModel extends MovieList {
  const MovieListModel({
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

  factory MovieListModel.fromJson(Map<String, dynamic> json) =>
      _$MovieListModelFromJson(json);

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

  Map<String, dynamic> toJson() => _$MovieListModelToJson(this);
}
