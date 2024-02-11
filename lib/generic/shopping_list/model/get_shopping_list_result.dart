import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/shopping_list/model/get_shopping_list_response.dart';

part 'get_shopping_list_result.freezed.dart';

@freezed
class GetShoppingListInfoResult with _$GetShoppingListInfoResult {
  const factory GetShoppingListInfoResult.success(GetShoppingListResponse list) = Success;

  const factory GetShoppingListInfoResult.failure(String message) = Failure;
}
