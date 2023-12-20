import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/my_channel/bloc/my_channel_bloc.dart';
import 'package:superkauf/feature/my_channel/view/my_channel_page.dart';
import 'package:superkauf/generic/post/use_case/get_posts_by_user.dart';

import '../../generic/user/use_case/get_user_by_uid_use_case.dart';
import '../../library/app_module.dart';

class MyChannelModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerUseCase() {}

  @override
  void registerBloc() {
    GetIt.I.registerFactory<MyChannelBloc>(() => MyChannelBloc(
          getPostsByUserUseCase: GetIt.I.get<GetPostsByUserUseCase>(),
          getUserByUidUseCase: GetIt.I.get<GetUserByUidUseCase>(),
        ));
  }

  @override
  void registerScreen() {
    GetIt.I.registerFactory<MyChannelScreen>(() => MyChannelScreen());
  }

  @override
  void registerRoute(routes) {
    routes[MyChannelScreen.name] = (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<MyChannelBloc>.value(
            value: GetIt.I.get<MyChannelBloc>(),
          ),
        ],
        child: GetIt.I.get<MyChannelScreen>(),
      );
    };
  }
}
