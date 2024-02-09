import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/feature/shopping_list/bloc/shopping_list_state.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';
import 'package:superkauf/generic/post/model/pagination_model.dart';
import 'package:superkauf/generic/saved_posts/model/get_saved_post_params.dart';
import 'package:superkauf/generic/saved_posts/use_case/get_saved_posts_by_user_use_case.dart';
import 'package:superkauf/generic/shopping_list/model/get_shopping_lists_for_user_result.dart';
import 'package:superkauf/generic/shopping_list/model/shopping_list_model.dart';
import 'package:superkauf/generic/shopping_list/use_case/get_shopping_list_for_user_use_case.dart';
import 'package:superkauf/generic/shopping_list/use_case/get_shopping_list_info_use_case.dart';
import 'package:superkauf/generic/store/model/get_stores_result.dart';
import 'package:superkauf/generic/store/model/store_model.dart';
import 'package:superkauf/generic/store/use_case/get_stores_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

part 'shopping_list_event.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetSavedPostsByUserUseCase getSavedPostsByUserUseCase;
  final GetShoppingListsForUserUseCase getShoppingListForUserUseCase;
  final GetShoppingListInfoUseCase getShoppingListInfoUseCase;
  final GetStoresUseCase getStoresUseCase;

  ShoppingListBloc({
    required this.getCurrentUserUseCase,
    required this.getSavedPostsByUserUseCase,
    required this.getShoppingListForUserUseCase,
    required this.getShoppingListInfoUseCase,
    required this.getStoresUseCase,
  }) : super(const ShoppingListState.loading()) {
    on<InitialEvent>(_onInitialEvent);
    on<PickShoppingList>(_onPickShoppingList);
    on<PickStore>(_onPickStore);
    // on<ReloadShoppingList>(_onReloadShoppingList);
    // on<LoadMore>(_onLoadMore);
  }

  var page = 0;
  var loading = false;
  static const perPage = 999;

  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<ShoppingListState> emit,
  ) async {
    final userResult = await getCurrentUserUseCase.call();
    if (userResult == null) {
      emit(const ShoppingListState.error("You are not logged in"));
      return;
    }

    final Future<GetStoresResult> storeCall = getStoresUseCase.call();
    final Future<GetShoppingListsForUserResult> shoppingListCall = getShoppingListForUserUseCase.call(userResult.id);

    final List<dynamic> results = await Future.wait([storeCall, shoppingListCall]);

    final GetStoresResult storesResult = results[0] as GetStoresResult;
    final GetShoppingListsForUserResult shoppingListResult = results[1] as GetShoppingListsForUserResult;

    var stores = <StoreModel>[];
    var shoppingLists = <ShoppingListModel>[];
    storesResult.map(
        success: (success) {
          stores.addAll(success.stores);
        },
        failure: (failure) {});

    shoppingListResult.map(
        success: (success) {
          shoppingLists.addAll(success.lists);
        },
        failure: (failure) {});

    emit(ShoppingListState.initial(shoppingLists, stores));
  }

  Future<void> _onPickShoppingList(
    PickShoppingList event,
    Emitter<ShoppingListState> emit,
  ) async {
    final result = await getShoppingListInfoUseCase.call(event.shoppingListId);
    result.map(
      success: (success) {
        emit(ShoppingListState.showShoppingList(success.list));
      },
      failure: (failure) {
        emit(ShoppingListState.error(failure.message));
      },
    );
  }

  Future<void> _onPickStore(
    PickStore event,
    Emitter<ShoppingListState> emit,
  ) async {
    final userResult = await getCurrentUserUseCase.call();
    if (userResult == null) {
      emit(const ShoppingListState.error("You are not logged in"));
      return;
    }

    final result = await getSavedPostsByUserUseCase.call(
      GetSavedPostsParams(
        userId: userResult.id,
        pagination: const GetPostsPaginationModel(perPage: perPage, offset: 0),
      ),
    );
    var storePosts = <FullContextPostModel>[];
    result.map(
      success: (success) {
        storePosts.addAll(success.response.posts);
      },
      failure: (failure) {
        emit(ShoppingListState.error(failure.message));
      },
    );

    emit(ShoppingListState.showStore(
      storePosts.where((element) => element.post.store == event.store.id).toList(),
      event.store,
    ));
  }

  // Future<void> _onReloadShoppingList(
  //   ReloadShoppingList event,
  //   Emitter<ShoppingListState> emit,
  // ) async {
  //   if (event.wait) {
  //     await Future.delayed(const Duration(milliseconds: 400));
  //   }
  //   page = 0;
  //
  //   emit(const ShoppingListState.loading());
  //   add(const GetShoppingList());
  // }

  // Future<void> _onLoadMore(
  //   LoadMore event,
  //   Emitter<ShoppingListState> emit,
  // ) async {
  //   if (loading) {
  //     return;
  //   }
  //   loading = true;
  //
  //   var shouldReturn = false;
  //   state.maybeMap(
  //     loaded: (loaded) {
  //       if (loaded.posts.length % perPage == 0) {
  //         emit(loaded.copyWith(isLoading: true));
  //       } else {
  //         shouldReturn = true;
  //       }
  //     },
  //     orElse: () {},
  //   );
  //   if (shouldReturn) {
  //     return;
  //   }
  //   page++;
  //   add(const GetShoppingList());
  // }
}
