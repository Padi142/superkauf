import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/search/bloc/search_bloc.dart';
import 'package:superkauf/feature/search/view/search_view.dart';
import 'package:superkauf/generic/settings/use_case/get_settings_use_case.dart';
import 'package:superkauf/generic/store/bloc/store_bloc.dart';
import 'package:superkauf/generic/store/use_case/get_posts_by_store_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

import '../../library/app_module.dart';

class SearchModule extends AppModule {
  @override
  void registerNavigation() {
    // GetIt.I.registerFactory<InitNavigation>(() => InitNavigation());
  }

  @override
  void registerBloc() {
    GetIt.I.registerFactory<SearchBloc>(
      () => SearchBloc(
        getPostsByStoreUseCase: GetIt.I.get<GetPostsByStoreUseCase>(),
        getCurrentUserUseCase: GetIt.I.get<GetCurrentUserUseCase>(),
        getSettingsUseCase: GetIt.I.get<GetSettingsUseCase>(),
      ),
    );
  }

  @override
  void registerScreen() {
    GetIt.I.registerFactory<SearchScreen>(() => SearchScreen());
  }

  @override
  void registerRoute(routes) {
    routes[SearchScreen.name] = (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<StoreBloc>.value(
            value: GetIt.I.get<StoreBloc>(),
          ),
          BlocProvider<SearchBloc>.value(
            value: GetIt.I.get<SearchBloc>(),
          ),
        ],
        child: GetIt.I.get<SearchScreen>(),
      );
    };
  }
}
