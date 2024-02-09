import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/shopping_list/model/shopping_list_model.dart';

part 'get_shopping_lists_for_user_result.freezed.dart';

@freezed
class GetShoppingListsForUserResult with _$GetShoppingListsForUserResult {
  const factory GetShoppingListsForUserResult.success(
    List<ShoppingListModel> lists,
  ) = Success;

  const factory GetShoppingListsForUserResult.failure(String message) = Failure;
}
