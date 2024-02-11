import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/feature/store_posts/bloc/store_posts_state.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';
import 'package:superkauf/generic/post/model/pagination_model.dart';
import 'package:superkauf/generic/settings/use_case/get_settings_use_case.dart';
import 'package:superkauf/generic/store/model/get_post_by_store_params.dart';
import 'package:superkauf/generic/store/use_case/get_posts_by_store_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

part 'store_posts_event.dart';

class StorePostsBloc extends Bloc<StorePostsEvent, StorePostsState> {
  final GetPostsByStoreUseCase getPostsByStoreUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetSettingsUseCase getSettingsUseCase;

  StorePostsBloc({
    required this.getPostsByStoreUseCase,
    required this.getCurrentUserUseCase,
    required this.getSettingsUseCase,
  }) : super(const StorePostsState.loading()) {
    on<GetPosts>(_onGetPosts);
    on<ReloadStorePosts>(_onReloadStorePosts);
    on<LoadMore>(_onLoadMore);
  }

  var storeId = -1;

  var page = 0;
  var loading = false;
  static const perPage = 5;

  Future<void> _onGetPosts(
    GetPosts event,
    Emitter<StorePostsState> emit,
  ) async {
    if (storeId != event.storeId) {
      page = 0;
      storeId = event.storeId;
      emit(const StorePostsState.loading());
    }
    final List<FullContextPostModel> newPosts = [];

    final settings = await getSettingsUseCase.call();

    final params = GetStorePostsParams(
      storeId: event.storeId,
      country: settings.country,
      pagination: GetPostsPaginationModel(
        offset: page * perPage,
        perPage: perPage,
      ),
    );

    final result = await getPostsByStoreUseCase.call(params);
    result.when(
      success: (success) {
        newPosts.addAll(success.posts);
      },
      failure: (message) {
        emit(StorePostsState.error(message));
      },
    );

    state.maybeMap(
        loaded: (loaded) {
          final posts = loaded.posts.toList();
          posts.addAll(newPosts);
          final canLoadMore = posts.length % perPage == 0;

          emit(
            StorePostsState.loaded(posts, false, canLoadMore),
          );
        },
        loading: (loading) {
          final canLoadMore = newPosts.length % perPage == 0;

          emit(
            StorePostsState.loaded(newPosts, false, canLoadMore),
          );
        },
        orElse: () {});
    loading = false;
  }

  Future<void> _onReloadStorePosts(
    ReloadStorePosts event,
    Emitter<StorePostsState> emit,
  ) async {
    if (event.wait) {
      await Future.delayed(const Duration(milliseconds: 400));
    }
    page = 0;

    emit(const StorePostsState.loading());
    add(GetPosts(storeId: storeId));
  }

  Future<void> _onLoadMore(
    LoadMore event,
    Emitter<StorePostsState> emit,
  ) async {
    if (loading) {
      return;
    }
    var shouldReturn = false;
    loading = true;
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
    add(GetPosts(storeId: event.storeId));
  }
}
