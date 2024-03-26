// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'configuration_model.freezed.dart';
part 'configuration_model.g.dart';

ConfigurationModel configurationModelFromJson(String str) =>
    ConfigurationModel.fromJson(json.decode(str) as Map<String, dynamic>);

String configurationModelToJson(ConfigurationModel data) =>
    json.encode(data.toJson());

@freezed
class ConfigurationModel with _$ConfigurationModel {
  const factory ConfigurationModel({
    Images? images,
    @JsonKey(name: 'change_keys') List<String>? changeKeys,
  }) = _ConfigurationModel;

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationModelFromJson(json);
}

@freezed
class Images with _$Images {
  const factory Images({
    @JsonKey(name: 'base_url') String? baseUrl,
    @JsonKey(name: 'secure_base_url') String? secureBaseUrl,
    @JsonKey(name: 'backdrop_sizes') List<String>? backdropSizes,
    @JsonKey(name: 'logo_sizes') List<String>? logoSizes,
    @JsonKey(name: 'poster_sizes') List<String>? posterSizes,
    @JsonKey(name: 'profile_sizes') List<String>? profileSizes,
    @JsonKey(name: 'still_sizes') List<String>? stillSizes,
  }) = _Images;

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
}
