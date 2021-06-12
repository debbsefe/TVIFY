import 'package:movie_colony/features/single_tv/domain/entities/tv_cast.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tv_cast_model.g.dart';

@JsonSerializable()
class TvCastModel extends TvCast {
  const TvCastModel({
    required this.name,
    required this.profileImage,
    required this.knownFor,
  }) : super(
          knownFor: knownFor,
          profileImage: profileImage,
          name: name,
        );

  factory TvCastModel.fromJson(Map<String, dynamic> json) =>
      _$TvCastModelFromJson(json);

  final String name;
  @JsonKey(name: 'profile_path')
  final String profileImage;
  @JsonKey(name: 'known_for_department')
  final String knownFor;

  Map<String, dynamic> toJson() => _$TvCastModelToJson(this);
}
