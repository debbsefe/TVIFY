import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_list_model.g.dart';

@JsonSerializable()
@UtcDateJsonConverter()
class NotificationListModel {
  NotificationListModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.date,
    required this.posterImage,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

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
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  Map<String, dynamic> toJson() => _$NotificationListModelToJson(this);
}

class UtcDateJsonConverter extends JsonConverter<DateTime, String> {
  const UtcDateJsonConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json).toLocal();
  }

  @override
  String toJson(DateTime object) {
    return object.toUtc().toIso8601String();
  }
}
