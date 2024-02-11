import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/shopping_list/model/shopping_list_model.dart';
import 'package:superkauf/generic/store/model/store_model.dart';

part 'saved_posts_panel_state.freezed.dart';

@freezed
abstract class SavedPostsPanelState with _$SavedPostsPanelState {
  const factory SavedPostsPanelState.loading() = Loading;
  const factory SavedPostsPanelState.openSavedPostPanel() = OpenSavedPostPanel;
  const factory SavedPostsPanelState.loaded(
    StoreModel store,
    List<ShoppingListModel> lists,
    int postId,
  ) = Loaded;
}
