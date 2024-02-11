import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/home/bloc/home_bloc/home_bloc.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/home/use_case/home_navigation.dart';
import 'package:superkauf/feature/home/view/home_screen.dart';
import 'package:superkauf/feature/snackbar/bloc/snackbar_bloc.dart';
import 'package:superkauf/generic/notifications/presentation/check_notifications_bloc.dart';
import 'package:superkauf/generic/post/bloc/post_bloc.dart';
import 'package:superkauf/generic/shopping_list/bloc/shopping_list_data_bloc.dart';
import 'package:superkauf/generic/shopping_list/use_case/get_shopping_list_for_user_use_case.dart';
import 'package:superkauf/generic/store/use_case/GetStoresUseCase.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

import '../../library/app_module.dart';
import 'bloc/saved_posts_panel_bloc/saved_posts_panel_bloc.dart';

class HomeModule extends AppModule {
  @override
  void registerNavigation() {
    GetIt.I.registerFactory<HomeNavigation>(() => HomeNavigation());
  }

  @override
  void registerBloc() {
    GetIt.I.registerSingleton<HomeBloc>(
      HomeBloc(
        homeNavigation: GetIt.I.get<HomeNavigation>(),
      ),
    );

    GetIt.I.registerSingleton<NavigationBloc>(
      NavigationBloc(),
    );

    GetIt.I.registerFactory<SavedPostsPanelBloc>(
      () => SavedPostsPanelBloc(
        getCurrentUserUseCase: GetIt.I.get<GetCurrentUserUseCase>(),
        getShoppingListForUserUseCase: GetIt.I.get<GetShoppingListsForUserUseCase>(),
        getStoreUseCase: GetIt.I.get<GetStoreUseCase>(),
      ),
    );
  }

  @override
  void registerScreen() {
    GetIt.I.registerFactory<HomeScreen>(() => HomeScreen());
  }

  @override
  void registerRoute(routes) {
    routes[HomeScreen.name] = (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>.value(
            value: GetIt.I.get<HomeBloc>(),
          ),
          BlocProvider<PostBloc>.value(
            value: GetIt.I.get<PostBloc>(),
          ),
          BlocProvider<SnackbarBloc>.value(
            value: GetIt.I.get<SnackbarBloc>(),
          ),
          BlocProvider<CheckNotificationBloc>.value(
            value: GetIt.I.get<CheckNotificationBloc>(),
          ),
          BlocProvider<SavedPostsPanelBloc>.value(
            value: GetIt.I.get<SavedPostsPanelBloc>(),
          ),
          BlocProvider<ShoppingListDataBloc>.value(
            value: GetIt.I.get<ShoppingListDataBloc>(),
          ),
        ],
        child: GetIt.I.get<HomeScreen>(),
      );
    };
  }
}
