import '../../domain/entities/configuration.dart';

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

  ImageModel images;
  List<String> changeKeys;

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) =>
      ConfigurationModel(
        images: ImageModel.fromJson(json["images"]),
        changeKeys: List<String>.from(json["change_keys"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "images": images.toJson(),
        "change_keys": List<dynamic>.from(changeKeys.map((x) => x)),
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

  String baseUrl;
  String secureBaseUrl;
  List<String> backdropSizes;
  List<String> logoSizes;
  List<String> posterSizes;
  List<String> profileSizes;
  List<String> stillSizes;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        baseUrl: json["base_url"],
        secureBaseUrl: json["secure_base_url"],
        backdropSizes: List<String>.from(json["backdrop_sizes"].map((x) => x)),
        logoSizes: List<String>.from(json["logo_sizes"].map((x) => x)),
        posterSizes: List<String>.from(json["poster_sizes"].map((x) => x)),
        profileSizes: List<String>.from(json["profile_sizes"].map((x) => x)),
        stillSizes: List<String>.from(json["still_sizes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "base_url": baseUrl,
        "secure_base_url": secureBaseUrl,
        "backdrop_sizes": List<dynamic>.from(backdropSizes.map((x) => x)),
        "logo_sizes": List<dynamic>.from(logoSizes.map((x) => x)),
        "poster_sizes": List<dynamic>.from(posterSizes.map((x) => x)),
        "profile_sizes": List<dynamic>.from(profileSizes.map((x) => x)),
        "still_sizes": List<dynamic>.from(stillSizes.map((x) => x)),
      };
}
