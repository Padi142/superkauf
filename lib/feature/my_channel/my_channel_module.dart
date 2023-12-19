import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/my_channel/view/my_channel_page.dart';

import '../../library/app_module.dart';

class MyChannelModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerUseCase() {}

  @override
  void registerBloc() {}

  @override
  void registerScreen() {
    GetIt.I.registerFactory<MyChannel>(() => MyChannel());
  }

  @override
  void registerRoute(routes) {
    routes[MyChannel.name] = (context) {
      return GetIt.I.get<MyChannel>();
    };
  }
}
