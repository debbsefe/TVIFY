import 'package:equatable/equatable.dart';

class TvCast extends Equatable {
  const TvCast({
    required this.name,
    required this.profileImage,
    required this.knownFor,
  });

  final String name, profileImage, knownFor;

  @override
  List<Object?> get props => [name, profileImage, knownFor];
}
