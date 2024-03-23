import 'package:dio/dio.dart';
import 'package:superkauf/generic/api/notification_api.dart';
import 'package:superkauf/generic/notifications/model/check_notification_result.dart';
import 'package:superkauf/generic/notifications/model/get_notifications_result.dart';

class NotificationRepository {
  final NotificationApi notificationApi;

  NotificationRepository({
    required this.notificationApi,
  });

  Future<GetNotificationsResult> getNotifications(int userId, int page, int limit) async {
    return notificationApi.getNotifications(userId: userId, page: page, limit: limit).then((notifications) {
      return GetNotificationsResult.success(notifications);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetNotificationsResult.failure(error.message ?? 'error getting notifications');
      }
      return const GetNotificationsResult.failure('error');
    });
  }

  Future<CheckNotificationResult> checkNotifications(int userId) async {
    return notificationApi.checkNotifications(userId: userId).then((notifications) {
      return CheckNotificationResult.success(notifications);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return CheckNotificationResult.failure(error.message ?? 'error getting notifications');
      }
      return const CheckNotificationResult.failure('error');
    });
  }
}
