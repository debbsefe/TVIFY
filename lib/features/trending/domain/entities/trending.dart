import 'package:equatable/equatable.dart';

class Trending extends Equatable {
  const Trending({
    required this.date,
    required this.rating,
    required this.backdropImage,
    required this.posterImage,
    required this.id,
    required this.name,
    required this.overview,
  });

  final int id;
  final String name;
  final String date, overview;
  final num rating;
  final String backdropImage;
  final String posterImage;

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
