import 'package:freezed_annotation/freezed_annotation.dart';
part 'notification_list_model.g.dart';

@JsonSerializable()
class NotificationListModel {
  NotificationListModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.date,
    required this.posterImage,
  });

  factory NotificationListModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationListModelFromJson(json);
  final int? id;
  final String? name;
  @JsonKey(name: 'vote_average')
  final num? rating;
  @JsonKey(name: 'first_air_date')
  final String? date;
  @JsonKey(name: 'poster_path')
  final String? posterImage;

  Map<String, dynamic> toJson() => _$NotificationListModelToJson(this);
}
