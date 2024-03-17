import 'package:equatable/equatable.dart';

class Configuration extends Equatable {
  const Configuration({
    required this.backdropSizes,
    required this.logoSizes,
    required this.posterSizes,
    required this.profileSizes,
    required this.stillSizes,
    required this.changeKeys,
    this.baseUrl,
    this.secureBaseUrl,
  });
  final String? baseUrl;
  final String? secureBaseUrl;
  final List<String> backdropSizes;
  final List<String> logoSizes;
  final List<String> posterSizes;
  final List<String> profileSizes;
  final List<String> stillSizes;
  final List<String> changeKeys;

  @override
  List<Object?> get props => [
        baseUrl,
        changeKeys,
        secureBaseUrl,
        backdropSizes,
        logoSizes,
        posterSizes,
        profileSizes,
        stillSizes,
      ];
}
