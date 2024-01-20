import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/notification_page/bloc/my_notifications_bloc.dart';
import 'package:superkauf/feature/notification_page/view/my_notifications_page.dart';
import 'package:superkauf/generic/notifications/user_case/get_notifications_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

import '../../library/app_module.dart';

class MyNotificationsModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerUseCase() {}

  @override
  void registerBloc() {
    GetIt.I.registerFactory<MyNotificationsBloc>(() => MyNotificationsBloc(
          getCurrentUserUseCase: GetIt.I.get<GetCurrentUserUseCase>(),
          getNotificationsUseCase: GetIt.I.get<GetNotificationsUseCase>(),
        ));
  }

  @override
  void registerScreen() {
    GetIt.I.registerFactory<MyNotificationsScreen>(() => MyNotificationsScreen());
  }

  @override
  void registerRoute(routes) {
    routes[MyNotificationsScreen.name] = (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<MyNotificationsBloc>.value(
            value: GetIt.I.get<MyNotificationsBloc>(),
          ),
        ],
        child: GetIt.I.get<MyNotificationsScreen>(),
      );
    };
  }
}
