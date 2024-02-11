import 'package:freezed_annotation/freezed_annotation.dart';

part 'shopping_list_data_state.freezed.dart';

@freezed
abstract class ShoppingListDataState with _$ShoppingListDataState {
  const factory ShoppingListDataState.loading() = Loading;
  const factory ShoppingListDataState.listJoined(int listId) = ListJoined;
  const factory ShoppingListDataState.listLeaved() = ListLeaved;
  const factory ShoppingListDataState.listDeleted() = ListDeleted;
  const factory ShoppingListDataState.error(message) = Error;
}
