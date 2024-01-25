import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/discover/bloc/discover_bloc.dart';
import 'package:superkauf/feature/discover/view/discover_page.dart';
import 'package:superkauf/generic/post/use_case/get_top_posts_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

import '../../library/app_module.dart';

class DiscoverModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerUseCase() {}

  @override
  void registerBloc() {
    GetIt.I.registerFactory<DiscoverBloc>(() => DiscoverBloc(
          getTopPostsUseCase: GetIt.I.get<GetTopPostsUseCase>(),
          getCurrentUserUseCase: GetIt.I.get<GetCurrentUserUseCase>(),
        ));
  }

  @override
  void registerScreen() {
    GetIt.I.registerFactory<DiscoverScreen>(() => DiscoverScreen());
  }

  @override
  void registerRoute(routes) {
    routes[DiscoverScreen.name] = (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<DiscoverBloc>.value(
            value: GetIt.I.get<DiscoverBloc>(),
          ),
        ],
        child: GetIt.I.get<DiscoverScreen>(),
      );
    };
  }
}
