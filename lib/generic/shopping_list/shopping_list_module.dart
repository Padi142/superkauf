import 'package:get_it/get_it.dart';
import 'package:superkauf/generic/api/shopping_list_api.dart';
import 'package:superkauf/generic/shopping_list/bloc/shopping_list_data_bloc.dart';
import 'package:superkauf/generic/shopping_list/data/shopping_list_repository.dart';
import 'package:superkauf/generic/shopping_list/use_case/add_saved_post_to_list_use_case.dart';
import 'package:superkauf/generic/shopping_list/use_case/create_shopping_list_use_case.dart';
import 'package:superkauf/generic/shopping_list/use_case/delete_list_use_case.dart';
import 'package:superkauf/generic/shopping_list/use_case/get_shopping_list_for_user_use_case.dart';
import 'package:superkauf/generic/shopping_list/use_case/get_shopping_list_info_use_case.dart';
import 'package:superkauf/generic/shopping_list/use_case/join_user_to_list_use_case.dart';
import 'package:superkauf/generic/shopping_list/use_case/remove_saved_post_from_list_use_case.dart';
import 'package:superkauf/generic/shopping_list/use_case/remove_user_from_list_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';
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
  void registerBloc() {
    GetIt.I.registerFactory<ShoppingListDataBloc>(
      () => ShoppingListDataBloc(
        addSavedPostToListUseCase: GetIt.I.get<AddSavedPostToListUseCase>(),
        getCurrentUserUseCase: GetIt.I.get<GetCurrentUserUseCase>(),
        removeSavedPostFromListUseCase: GetIt.I.get<RemoveSavedPostFromListUseCase>(),
        createShoppingListUseCase: GetIt.I.get<CreateShoppingListUseCase>(),
        joinShoppingListUseCase: GetIt.I.get<JoinUserToShoppingListUseCase>(),
        removeUserFromShoppingListUseCase: GetIt.I.get<RemoveUserFromShoppingListUseCase>(),
        deleteListUseCase: GetIt.I.get<DeleteListUseCase>(),
        getShoppingListInfoUseCase: GetIt.I.get<GetShoppingListInfoUseCase>(),
      ),
    );
  }

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

    GetIt.I.registerFactory<AddSavedPostToListUseCase>(
      () => AddSavedPostToListUseCase(
        repository: GetIt.I.get<ShoppingListRepository>(),
      ),
    );

    GetIt.I.registerFactory<RemoveSavedPostFromListUseCase>(
      () => RemoveSavedPostFromListUseCase(
        repository: GetIt.I.get<ShoppingListRepository>(),
      ),
    );

    GetIt.I.registerFactory<CreateShoppingListUseCase>(
      () => CreateShoppingListUseCase(
        repository: GetIt.I.get<ShoppingListRepository>(),
      ),
    );

    GetIt.I.registerFactory<JoinUserToShoppingListUseCase>(
      () => JoinUserToShoppingListUseCase(
        repository: GetIt.I.get<ShoppingListRepository>(),
      ),
    );

    GetIt.I.registerFactory<RemoveUserFromShoppingListUseCase>(
      () => RemoveUserFromShoppingListUseCase(
        repository: GetIt.I.get<ShoppingListRepository>(),
      ),
    );

    GetIt.I.registerFactory<DeleteListUseCase>(
      () => DeleteListUseCase(
        repository: GetIt.I.get<ShoppingListRepository>(),
      ),
    );
  }

  @override
  void registerDI() {}
}
