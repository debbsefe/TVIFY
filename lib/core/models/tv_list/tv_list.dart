import 'package:equatable/equatable.dart';

class TvList extends Equatable {
  const TvList({
    this.date,
    this.rating,
    this.backdropImage,
    this.posterImage,
    this.id,
    this.name,
    this.overview,
  });

  final int? id;
  final String? name, date, overview, backdropImage, posterImage;
  final num? rating;

  @override
  List<Object?> get props => [
        id,
        name,
        date,
        rating,
        backdropImage,
        posterImage,
      ];
}
