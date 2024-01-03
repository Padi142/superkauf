import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/feature/shopping_list/bloc/shopping_list_state.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';
import 'package:superkauf/generic/post/model/pagination_model.dart';
import 'package:superkauf/generic/saved_posts/model/get_saved_post_params.dart';
import 'package:superkauf/generic/saved_posts/use_case/get_saved_posts_by_user_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

part 'shopping_list_event.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetSavedPostsByUserUseCase getSavedPostsByUserUseCase;

  ShoppingListBloc({
    required this.getCurrentUserUseCase,
    required this.getSavedPostsByUserUseCase,
  }) : super(const ShoppingListState.loading()) {
    on<GetShoppingList>(_onGetShoppingList);
    on<ReloadShoppingList>(_onReloadShoppingList);
    on<LoadMore>(_onLoadMore);
  }

  var page = 0;
  var loading = false;
  static const perPage = 5;

  Future<void> _onGetShoppingList(
    GetShoppingList event,
    Emitter<ShoppingListState> emit,
  ) async {
    final userResult = await getCurrentUserUseCase.call();
    if (userResult == null) {
      emit(const ShoppingListState.error("You are not logged in"));
      return;
    }

    final params = GetSavedPostsParams(
      userId: userResult.id,
      pagination: GetPostsPaginationModel(
        offset: page * perPage,
        perPage: perPage,
      ),
    );

    final result = await getSavedPostsByUserUseCase.call(params);
    final List<FullContextPostModel> newPosts = [];

    result.map(success: (success) {
      final canLoadMore = success.response.pagination.count % perPage == 0;

      newPosts.addAll(success.response.posts);
    }, failure: (failure) {
      emit(ShoppingListState.error(failure.message));
    });

    state.maybeMap(
        loaded: (loaded) {
          final posts = loaded.posts.toList();
          posts.addAll(newPosts);
          final canLoadMore = posts.length % perPage == 0;

          emit(
            ShoppingListState.loaded(posts, false, canLoadMore),
          );
        },
        loading: (loading) {
          final canLoadMore = newPosts.length % perPage == 0;

          emit(
            ShoppingListState.loaded(newPosts, false, canLoadMore),
          );
        },
        orElse: () {});

    loading = false;
  }

  Future<void> _onReloadShoppingList(
    ReloadShoppingList event,
    Emitter<ShoppingListState> emit,
  ) async {
    if (event.wait) {
      await Future.delayed(const Duration(milliseconds: 400));
    }
    page = 0;

    emit(const ShoppingListState.loading());
    add(const GetShoppingList());
  }

  Future<void> _onLoadMore(
    LoadMore event,
    Emitter<ShoppingListState> emit,
  ) async {
    if (loading) {
      return;
    }
    loading = true;

    var shouldReturn = false;
    state.maybeMap(
      loaded: (loaded) {
        if (loaded.posts.length % perPage == 0) {
          emit(loaded.copyWith(isLoading: true));
        } else {
          shouldReturn = true;
        }
      },
      orElse: () {},
    );
    if (shouldReturn) {
      return;
    }
    page++;
    add(const GetShoppingList());
  }
}
