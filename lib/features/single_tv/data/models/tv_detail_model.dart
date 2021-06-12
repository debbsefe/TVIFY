import '../../../categories/domain/entities/categories.dart';
import '../../domain/entities/tv_detail.dart';

class TvDetailModel extends TvDetail {
  const TvDetailModel({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.name,
    required this.numberOfSeasons,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.categories,
  }) : super(
          id: id,
          name: name,
          rating: voteAverage,
          posterImage: posterPath,
          backdropImage: backdropPath,
          overview: overview,
          categories: categories,
          seasons: numberOfSeasons,
          startDate: firstAirDate,
        );

  factory TvDetailModel.fromJson(Map<String, dynamic> json) => TvDetailModel(
        backdropPath: json['backdrop_path'],
        firstAirDate: json['first_air_date'],
        genres: List<Genre>.from(json['genres'].map((x) => Genre.fromJson(x))),
        id: json['id'],
        name: json['name'],
        numberOfSeasons: json['number_of_seasons'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        voteAverage: json['vote_average'].toDouble(),
        categories: List<Categories>.from(json['genres'].map((x) => Categories(
              id: x['id'],
              name: x['name'],
            ))),
      );

  final String backdropPath;
  final String firstAirDate;
  final List<Genre> genres;
  final int id;
  final String name;

  final int numberOfSeasons;

  final String overview;
  final String posterPath;
  final List<Categories> categories;

  final double voteAverage;
  Map<String, dynamic> toJson() => {
        'backdrop_path': backdropPath,
        'first_air_date': firstAirDate,
        'genres': List<dynamic>.from(genres.map((x) => x.toJson())),
        'id': id,
        'name': name,
        'number_of_seasons': numberOfSeasons,
        'overview': overview,
        'poster_path': posterPath,
        'vote_average': voteAverage,
      };
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });
  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json['id'],
        name: json['name'],
      );

  final int id;
  final String name;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
