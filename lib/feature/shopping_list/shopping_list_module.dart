import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:superkauf/feature/shopping_list/bloc/shopping_list_bloc.dart';
import 'package:superkauf/feature/shopping_list/view/shopping_list_screen.dart';
import 'package:superkauf/generic/saved_posts/use_case/get_saved_posts_by_user_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';
import 'package:superkauf/library/app_module.dart';

class ShoppingListModule extends AppModule {
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
