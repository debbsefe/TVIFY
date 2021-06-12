import 'package:equatable/equatable.dart';

import '../../../categories/domain/entities/categories.dart';

class TvDetail extends Equatable {
  const TvDetail({
    required this.startDate,
    required this.rating,
    required this.backdropImage,
    required this.posterImage,
    required this.id,
    required this.name,
    required this.overview,
    required this.categories,
    required this.seasons,
  });
  final int id, seasons;
  final String name;
  final String startDate, overview;
  final num rating;
  final String backdropImage;
  final String posterImage;
  final List<Categories> categories;

  @override
  List<Object?> get props => [
        id,
        name,
        startDate,
        rating,
        backdropImage,
        posterImage,
        categories,
        seasons,
        overview,
      ];
}
