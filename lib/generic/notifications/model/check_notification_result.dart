import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/notifications/model/models/check_notification_response.dart';

part 'check_notification_result.freezed.dart';

@freezed
class CheckNotificationResult with _$CheckNotificationResult {
  const factory CheckNotificationResult.success(CheckNotificationResponse response) = Success;

  const factory CheckNotificationResult.failure(String message) = Failure;
}
