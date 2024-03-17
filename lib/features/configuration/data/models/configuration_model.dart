import 'package:movie_colony/features/configuration/domain/entities/configuration.dart';

// ignore: must_be_immutable
class ConfigurationModel extends Configuration {
  ConfigurationModel({
    required this.images,
    required this.changeKeys,
  }) : super(
          backdropSizes: images.backdropSizes,
          secureBaseUrl: images.secureBaseUrl,
          baseUrl: images.baseUrl,
          posterSizes: images.posterSizes,
          profileSizes: images.profileSizes,
          stillSizes: images.stillSizes,
          logoSizes: images.logoSizes,
          changeKeys: changeKeys,
        );

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) =>
      ConfigurationModel(
        images: ImageModel.fromJson(json['images'] as Map<String, dynamic>),
        changeKeys: List<String>.from(
          (json['change_keys'] as List<dynamic>).map((x) => x),
        ),
      );

  ImageModel images;
  List<String> changeKeys;

  Map<String, dynamic> toJson() => {
        'images': images.toJson(),
        'change_keys': List<dynamic>.from(changeKeys.map((x) => x)),
      };
}

class ImageModel {
  ImageModel({
    required this.baseUrl,
    required this.secureBaseUrl,
    required this.backdropSizes,
    required this.logoSizes,
    required this.posterSizes,
    required this.profileSizes,
    required this.stillSizes,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        baseUrl: json['base_url'] as String,
        secureBaseUrl: json['secure_base_url'] as String,
        backdropSizes: List<String>.from(
          (json['backdrop_sizes'] as List<dynamic>).map((x) => x as String),
        ),
        logoSizes: List<String>.from(
          (json['logo_sizes'] as List<dynamic>).map((x) => x as String),
        ),
        posterSizes: List<String>.from(
          (json['poster_sizes'] as List<dynamic>).map((x) => x as String),
        ),
        profileSizes: List<String>.from(
          (json['profile_sizes'] as List<dynamic>).map((x) => x as String),
        ),
        stillSizes: List<String>.from(
          (json['still_sizes'] as List<dynamic>).map((x) => x as String),
        ),
      );

  String baseUrl;
  String secureBaseUrl;
  List<String> backdropSizes;
  List<String> logoSizes;
  List<String> posterSizes;
  List<String> profileSizes;
  List<String> stillSizes;

  Map<String, dynamic> toJson() => {
        'base_url': baseUrl,
        'secure_base_url': secureBaseUrl,
        'backdrop_sizes': List<dynamic>.from(backdropSizes.map((x) => x)),
        'logo_sizes': List<dynamic>.from(logoSizes.map((x) => x)),
        'poster_sizes': List<dynamic>.from(posterSizes.map((x) => x)),
        'profile_sizes': List<dynamic>.from(profileSizes.map((x) => x)),
        'still_sizes': List<dynamic>.from(stillSizes.map((x) => x)),
      };
}
