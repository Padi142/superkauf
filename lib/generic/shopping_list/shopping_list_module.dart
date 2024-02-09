import 'package:get_it/get_it.dart';
import 'package:superkauf/generic/api/shopping_list_api.dart';
import 'package:superkauf/generic/shopping_list/data/shopping_list_repository.dart';
import 'package:superkauf/generic/shopping_list/use_case/get_shopping_list_for_user_use_case.dart';
import 'package:superkauf/generic/shopping_list/use_case/get_shopping_list_info_use_case.dart';
import 'package:superkauf/library/app_module.dart';

class ShoppingListModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerRepo() {
    GetIt.I.registerFactory<ShoppingListRepository>(
      () => ShoppingListRepository(
        shoppingListApi: GetIt.I.get<ShoppingListApi>(),
      ),
    );
  }

  @override
  void registerBloc() {}

  @override
  void registerScreen() {}

  @override
  void registerUseCase() {
    GetIt.I.registerFactory<GetShoppingListInfoUseCase>(
      () => GetShoppingListInfoUseCase(
        repository: GetIt.I.get<ShoppingListRepository>(),
      ),
    );

    GetIt.I.registerFactory<GetShoppingListsForUserUseCase>(
      () => GetShoppingListsForUserUseCase(
        repository: GetIt.I.get<ShoppingListRepository>(),
      ),
    );
  }

  @override
  void registerDI() {}
}
