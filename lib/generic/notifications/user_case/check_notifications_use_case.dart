import 'package:superkauf/generic/notifications/data/notification_repository.dart';
import 'package:superkauf/generic/notifications/model/check_notification_result.dart';
import 'package:superkauf/library/use_case.dart';

class CheckNotificationUseCase extends UseCase<CheckNotificationResult, int> {
  NotificationRepository repository;

  CheckNotificationUseCase({
    required this.repository,
  });

  @override
  Future<CheckNotificationResult> call(params) async {
    return await repository.checkNotifications(params);
  }
}
