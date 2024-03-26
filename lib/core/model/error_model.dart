// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_model.freezed.dart';
part 'error_model.g.dart';

ErrorModel errorModelFromJson(String str) =>
    ErrorModel.fromJson(json.decode(str) as Map<String, dynamic>);

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

@freezed
class ErrorModel with _$ErrorModel {
  const factory ErrorModel({
    bool? success,
    @JsonKey(name: 'status_code') int? statusCode,
    @JsonKey(name: 'status_message') String? statusMessage,
  }) = _ErrorModel;

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);
}
