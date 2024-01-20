import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:superkauf/generic/notifications/model/models/check_notification_response.dart';
import 'package:superkauf/generic/notifications/model/models/notification_model.dart';

part 'notification_api.g.dart';

@RestApi()
abstract class NotificationApi {
  factory NotificationApi(Dio dio) = _NotificationApi;

  @GET('/notifications/{userId}')
  Future<List<NotificationModel>> getNotifications({
    @Path('userId') required int userId,
  });

  @GET('/notifications/{userId}/check')
  Future<CheckNotificationResponse> checkNotifications({
    @Path('userId') required int userId,
  });
}
