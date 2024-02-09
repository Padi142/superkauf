import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/shopping_list/bloc/shopping_list_bloc.dart';
import 'package:superkauf/feature/shopping_list/view/shopping_list_screen.dart';
import 'package:superkauf/generic/saved_posts/use_case/get_saved_posts_by_user_use_case.dart';
import 'package:superkauf/generic/shopping_list/use_case/get_shopping_list_for_user_use_case.dart';
import 'package:superkauf/generic/shopping_list/use_case/get_shopping_list_info_use_case.dart';
import 'package:superkauf/generic/store/use_case/get_stores_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';
import 'package:superkauf/library/app_module.dart';

class ShoppingListScreenModule extends AppModule {
  @override
  void registerNavigation() {
    // GetIt.I.registerFactory<InitNavigation>(() => InitNavigation());
  }

  @override
  void registerBloc() {
    GetIt.I.registerFactory<ShoppingListBloc>(
      () => ShoppingListBloc(
        getCurrentUserUseCase: GetIt.I.get<GetCurrentUserUseCase>(),
        getSavedPostsByUserUseCase: GetIt.I.get<GetSavedPostsByUserUseCase>(),
        getShoppingListForUserUseCase: GetIt.I.get<GetShoppingListsForUserUseCase>(),
        getShoppingListInfoUseCase: GetIt.I.get<GetShoppingListInfoUseCase>(),
        getStoresUseCase: GetIt.I.get<GetStoresUseCase>(),
      ),
    );
  }

  @override
  void registerScreen() {
    GetIt.I.registerFactory<ShoppingListScreen>(() => ShoppingListScreen());
  }

  @override
  void registerRoute(routes) {
    routes[ShoppingListScreen.name] = (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<ShoppingListBloc>.value(
            value: GetIt.I.get<ShoppingListBloc>(),
          ),
        ],
        child: GetIt.I.get<ShoppingListScreen>(),
      );
    };
  }
}
