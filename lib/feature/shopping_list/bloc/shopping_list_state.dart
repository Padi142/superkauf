import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';

part 'shopping_list_state.freezed.dart';

@freezed
abstract class ShoppingListState with _$ShoppingListState {
  const factory ShoppingListState.loading() = Loading;

  const factory ShoppingListState.loaded(
    List<FullContextPostModel> posts,
    bool isLoading,
    bool canLoadMore,
  ) = Loaded;

  const factory ShoppingListState.error(String error) = Error;
}
