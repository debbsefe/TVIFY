import 'package:equatable/equatable.dart';

import '../../../categories/domain/entities/categories.dart';

class TvDetail extends Equatable {
  const TvDetail({
    this.startDate,
    this.rating,
    this.backdropImage,
    this.posterImage,
    this.id,
    this.name,
    this.overview,
    this.categories,
    this.seasons,
  });
  final int? id, seasons;
  final String? name;
  final String? startDate, overview;
  final num? rating;
  final String? backdropImage;
  final String? posterImage;
  final List<Categories>? categories;

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
