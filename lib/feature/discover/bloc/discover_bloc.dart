import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';
import 'package:superkauf/generic/post/model/pagination_model.dart';
import 'package:superkauf/generic/post/use_case/get_top_posts_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

import 'discover_state.dart';

part 'discover_event.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final GetTopPostsUseCase getTopPostsUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  DiscoverBloc({
    required this.getTopPostsUseCase,
    required this.getCurrentUserUseCase,
  }) : super(const DiscoverState.loading()) {
    on<GetTopPosts>(_onGetTopPosts);
    on<LoadMore>(_onLoadMore);
    on<ReloadPosts>(_onReloadPosts);
  }

  var page = 0;
  var loading = false;
  static const perPage = 5;

  Future<void> _onGetTopPosts(
    GetTopPosts event,
    Emitter<DiscoverState> emit,
  ) async {
    final List<FullContextPostModel> newPosts = [];

    final user = await getCurrentUserUseCase.call();

    final params = GetPersonalFeedParams(
      userId: user?.id ?? 0,
      pagination: GetPostsPaginationModel(
        offset: page * perPage,
        perPage: perPage,
      ),
    );

    final result = await getTopPostsUseCase.call(params);
    result.when(
      success: (success) {
        newPosts.addAll(success.posts);
      },
      failure: (message) {
        emit(DiscoverState.error(message));
      },
    );

    state.maybeMap(
        loaded: (loaded) {
          final posts = loaded.posts.toList();
          posts.addAll(newPosts);
          final canLoadMore = posts.length % perPage == 0;

          emit(
            DiscoverState.loaded(posts, false, canLoadMore),
          );
        },
        loading: (loading) {
          final canLoadMore = newPosts.length % perPage == 0;

          emit(
            DiscoverState.loaded(newPosts, false, canLoadMore),
          );
        },
        orElse: () {});

    loading = false;
  }

  Future<void> _onReloadPosts(
    ReloadPosts event,
    Emitter<DiscoverState> emit,
  ) async {
    page = 0;

    emit(const DiscoverState.loading());
    add(const GetTopPosts());
  }

  Future<void> _onLoadMore(
    LoadMore event,
    Emitter<DiscoverState> emit,
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
    add(const GetTopPosts());
  }
}
