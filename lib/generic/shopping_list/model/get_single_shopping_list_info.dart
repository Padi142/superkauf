import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/shopping_list/model/shopping_list_model.dart';

part 'get_single_shopping_list_info.freezed.dart';

@freezed
class GetSingleShoppingListInfoResult with _$GetSingleShoppingListInfoResult {
  const factory GetSingleShoppingListInfoResult.success(ShoppingListModel list) = Success;

  const factory GetSingleShoppingListInfoResult.failure(String message) = Failure;
}
