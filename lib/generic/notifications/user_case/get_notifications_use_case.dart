import 'package:superkauf/generic/notifications/data/notification_repository.dart';
import 'package:superkauf/generic/notifications/model/get_notifications_result.dart';
import 'package:superkauf/library/use_case.dart';

class GetNotificationsUseCase extends UseCase<GetNotificationsResult, int> {
  NotificationRepository repository;

  GetNotificationsUseCase({
    required this.repository,
  });

  @override
  Future<GetNotificationsResult> call(params) async {
    return await repository.getNotifications(params);
  }
}
