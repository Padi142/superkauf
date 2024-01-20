import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/notifications/model/models/notification_model.dart';

part 'get_notifications_result.freezed.dart';

@freezed
class GetNotificationsResult with _$GetNotificationsResult {
  const factory GetNotificationsResult.success(List<NotificationModel> notifications) = Success;

  const factory GetNotificationsResult.failure(String message) = Failure;
}
