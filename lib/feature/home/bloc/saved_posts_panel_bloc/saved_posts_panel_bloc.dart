import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/generic/shopping_list/model/get_shopping_lists_for_user_result.dart';
import 'package:superkauf/generic/shopping_list/model/shopping_list_model.dart';
import 'package:superkauf/generic/shopping_list/use_case/get_shopping_list_for_user_use_case.dart';
import 'package:superkauf/generic/store/model/get_store_result.dart';
import 'package:superkauf/generic/store/model/store_model.dart';
import 'package:superkauf/generic/store/use_case/GetStoresUseCase.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

import 'saved_posts_panel_state.dart';

part 'saved_posts_panel_event.dart';

class SavedPostsPanelBloc extends Bloc<SavedPostsPanelEvent, SavedPostsPanelState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetShoppingListsForUserUseCase getShoppingListForUserUseCase;
  final GetStoreUseCase getStoreUseCase;

  SavedPostsPanelBloc({
    required this.getCurrentUserUseCase,
    required this.getShoppingListForUserUseCase,
    required this.getStoreUseCase,
  }) : super(const SavedPostsPanelState.loading()) {
    on<Initial>(_onInitial);
    on<OpenSavedPostsPanel>(_onOpenSavedPostsPanel);
  }

  Future<void> _onInitial(
    Initial event,
    Emitter<SavedPostsPanelState> emit,
  ) async {
    emit(const SavedPostsPanelState.loading());

    final userResult = await getCurrentUserUseCase();
    if (userResult == null) {
      emit(const SavedPostsPanelState.loading());
      return;
    }
    final shoppingListsCall = getShoppingListForUserUseCase.call(userResult.id);
    final storeCall = getStoreUseCase.call(event.storeId);

    final List<dynamic> results = await Future.wait([shoppingListsCall, storeCall]);

    final GetShoppingListsForUserResult shoppingListResult = results[0] as GetShoppingListsForUserResult;
    final GetStoreResult storeResult = results[1] as GetStoreResult;

    late StoreModel store;
    var shoppingLists = <ShoppingListModel>[];

    shoppingListResult.map(
        success: (success) {
          shoppingLists = success.lists;
        },
        failure: (failure) {});

    storeResult.map(
        success: (success) {
          store = success.store;
        },
        failure: (failure) {});

    emit(SavedPostsPanelState.loaded(
      store,
      shoppingLists,
      event.postId,
    ));
  }

  Future<void> _onOpenSavedPostsPanel(
    OpenSavedPostsPanel event,
    Emitter<SavedPostsPanelState> emit,
  ) async {
    emit(const SavedPostsPanelState.openSavedPostPanel());
    add(Initial(storeId: event.storeId, postId: event.postId));
    emit(const SavedPostsPanelState.loading());
  }
}
