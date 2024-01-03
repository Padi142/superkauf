import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/store_posts/bloc/store_posts_bloc.dart';
import 'package:superkauf/feature/store_posts/view/store_posts_view.dart';
import 'package:superkauf/generic/store/bloc/store_bloc.dart';
import 'package:superkauf/generic/store/use_case/get_posts_by_store_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

import '../../library/app_module.dart';

class StorePostsModule extends AppModule {
  @override
  void registerNavigation() {
    // GetIt.I.registerFactory<InitNavigation>(() => InitNavigation());
  }

  @override
  void registerBloc() {
    GetIt.I.registerFactory<StorePostsBloc>(
      () => StorePostsBloc(
        getPostsByStoreUseCase: GetIt.I.get<GetPostsByStoreUseCase>(),
        getCurrentUserUseCase: GetIt.I.get<GetCurrentUserUseCase>(),
      ),
    );
  }

  @override
  void registerScreen() {
    GetIt.I.registerFactory<StorePostsScreen>(() => StorePostsScreen());
  }

  @override
  void registerRoute(routes) {
    routes[StorePostsScreen.name] = (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<StoreBloc>.value(
            value: GetIt.I.get<StoreBloc>(),
          ),
          BlocProvider<StorePostsBloc>.value(
            value: GetIt.I.get<StorePostsBloc>(),
          ),
        ],
        child: GetIt.I.get<StorePostsScreen>(),
      );
    };
  }
}
