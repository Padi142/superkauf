import 'package:get_it/get_it.dart';
import 'package:superkauf/generic/api/notification_api.dart';
import 'package:superkauf/generic/notifications/data/notification_repository.dart';
import 'package:superkauf/generic/notifications/presentation/check_notifications_bloc.dart';
import 'package:superkauf/generic/notifications/user_case/check_notifications_use_case.dart';
import 'package:superkauf/generic/notifications/user_case/get_notifications_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';
import 'package:superkauf/library/app_module.dart';

class NotificationModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerRepo() {
    GetIt.I.registerFactory<NotificationRepository>(
      () => NotificationRepository(
        notificationApi: GetIt.I.get<NotificationApi>(),
      ),
    );
  }

  @override
  void registerBloc() {
    GetIt.I.registerFactory<CheckNotificationBloc>(
      () => CheckNotificationBloc(
        checkNotificationsUseCase: GetIt.I.get<CheckNotificationUseCase>(),
        getCurrentUserUseCase: GetIt.I.get<GetCurrentUserUseCase>(),
      ),
    );
  }

  @override
  void registerScreen() {}

  @override
  void registerUseCase() {
    GetIt.I.registerFactory<GetNotificationsUseCase>(
      () => GetNotificationsUseCase(repository: GetIt.I.get<NotificationRepository>()),
    );

    GetIt.I.registerFactory<CheckNotificationUseCase>(
      () => CheckNotificationUseCase(repository: GetIt.I.get<NotificationRepository>()),
    );
  }

  @override
  void registerDI() {}
}
