import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/notifications/model/models/notification_model.dart';

part 'my_notifications_state.freezed.dart';

@freezed
abstract class MyNotificationsState with _$MyNotificationsState {
  const factory MyNotificationsState.loading() = Loading;

  const factory MyNotificationsState.loaded(
    List<NotificationModel> notifications,
    bool isLoading,
    bool canLoadMore,
  ) = Loaded;

  const factory MyNotificationsState.error(String error) = Error;
}
