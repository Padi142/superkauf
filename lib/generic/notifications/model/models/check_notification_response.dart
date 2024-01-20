import 'package:json_annotation/json_annotation.dart';

part 'check_notification_response.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CheckNotificationResponse {
  final bool newNotifications;
  final int notificationCount;

  const CheckNotificationResponse({
    required this.newNotifications,
    required this.notificationCount,
  });

  factory CheckNotificationResponse.fromJson(Map<String, dynamic> json) => _$CheckNotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckNotificationResponseToJson(this);
}
