import 'package:equatable/equatable.dart';

class TvCast extends Equatable {
  const TvCast({
    this.id,
    this.name,
    this.profileImage,
    this.knownFor,
  });

  final String? name;
  final String? profileImage;
  final String? knownFor;
  final int? id;

  @override
  List<Object?> get props => [name, profileImage, knownFor, id];
}
