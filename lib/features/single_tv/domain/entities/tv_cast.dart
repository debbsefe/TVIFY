import 'package:equatable/equatable.dart';

class TvCast extends Equatable {
  const TvCast({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.knownFor,
  });

  final String name, profileImage, knownFor;
  final int id;

  @override
  List<Object?> get props => [name, profileImage, knownFor, id];
}
