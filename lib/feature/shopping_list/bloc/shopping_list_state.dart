import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';
import 'package:superkauf/generic/shopping_list/model/get_shopping_list_response.dart';
import 'package:superkauf/generic/shopping_list/model/shopping_list_model.dart';
import 'package:superkauf/generic/store/model/store_model.dart';

part 'shopping_list_state.freezed.dart';

@freezed
abstract class ShoppingListState with _$ShoppingListState {
  const factory ShoppingListState.loading() = Loading;
  const factory ShoppingListState.initial(
    List<ShoppingListModel> shoppingLists,
    List<StoreModel> stores,
  ) = Initial;

  const factory ShoppingListState.pickList(
    List<ShoppingListModel> shoppingLists,
    List<StoreModel> stores,
  ) = PickList;

  const factory ShoppingListState.showShoppingList(
    GetShoppingListResponse list,
  ) = ShowShoppingList;

  const factory ShoppingListState.showStore(List<FullContextPostModel> posts, StoreModel store
      // bool isLoading,
      // bool canLoadMore,
      ) = ShowStore;

  const factory ShoppingListState.error(String error) = Error;
}
