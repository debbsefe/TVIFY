// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tv_cast_model.freezed.dart';
part 'tv_cast_model.g.dart';

TvCastModel tvCastModelFromJson(String str) =>
    TvCastModel.fromJson(json.decode(str) as Map<String, dynamic>);

String tvCastModelToJson(TvCastModel data) => json.encode(data.toJson());

@freezed
class TvCastModel with _$TvCastModel {
  const factory TvCastModel({
    List<Cast>? cast,
    List<Cast>? crew,
    int? id,
  }) = _TvCastModel;

  factory TvCastModel.fromJson(Map<String, dynamic> json) =>
      _$TvCastModelFromJson(json);
}

@freezed
class Cast with _$Cast {
  const factory Cast({
    bool? adult,
    int? gender,
    int? id,
    @JsonKey(name: 'known_for_department') String? knownForDepartment,
    String? name,
    @JsonKey(name: 'original_name') String? originalName,
    double? popularity,
    @JsonKey(name: 'profile_path') String? profilePath,
    String? character,
    @JsonKey(name: 'credit_id') String? creditId,
    int? order,
    @JsonKey(name: 'department') String? department,
    String? job,
  }) = _Cast;

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
}
