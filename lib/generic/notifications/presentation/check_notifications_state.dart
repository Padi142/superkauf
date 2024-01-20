import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/notifications/model/models/check_notification_response.dart';

part 'check_notifications_state.freezed.dart';

@freezed
abstract class CheckNotificationsState with _$CheckNotificationsState {
  const factory CheckNotificationsState.loading() = Loading;

  const factory CheckNotificationsState.success(CheckNotificationResponse notifications) = Success;

  const factory CheckNotificationsState.error(String error) = Error;
}
