import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:superkauf/feature/feed/bloc/feed_state.dart';
import 'package:superkauf/generic/post/model/get_posts_body.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';
import 'package:superkauf/generic/post/model/pagination_model.dart';
import 'package:superkauf/generic/post/use_case/get_personal_feed_use_case.dart';
import 'package:superkauf/generic/post/use_case/get_posts_use_case.dart';
import 'package:superkauf/generic/settings/use_case/get_settings_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

part 'feed_event.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetPostsUseCase getPostsUseCase;
  final GetPersonalFeedUseCase getPersonalFeedUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetSettingsUseCase getSettingsUseCase;

  FeedBloc({
    required this.getPostsUseCase,
    required this.getPersonalFeedUseCase,
    required this.getCurrentUserUseCase,
    required this.getSettingsUseCase,
  }) : super(const FeedState.loading()) {
    on<GetFeed>(_onGetFeed);
    on<ReloadFeed>(_onReloadFeed);
    on<LoadMore>(_onLoadMore);
  }

  var page = 0;
  var loading = false;
  static const perPage = 5;

  Future<void> _onGetFeed(
    GetFeed event,
    Emitter<FeedState> emit,
  ) async {
    final user = await getCurrentUserUseCase.call();

    final settings = await getSettingsUseCase.call();

    final params = GetPostsBody(
      country: settings.country,
      pagination: GetPostsPaginationModel(
        offset: page * perPage,
        perPage: perPage,
      ),
    );

    final List<FullContextPostModel> newPosts = [];
    var canLoadMore = false;

    //Load feed for not-logged user
    if (user == null) {
      final result = await getPostsUseCase.call(params);

      result.map(success: (success) {
        newPosts.addAll(success.response.posts.map((element) => FullContextPostModel(
              post: element.post,
              user: element.user,
              reaction: null,
              saved: null,
            )));
        canLoadMore = success.response.pagination.count % perPage == 0;
      }, failure: (failure) {
        emit(FeedState.error(failure.message));
      });
    } else {
      final result = await getPersonalFeedUseCase.call(GetPersonalFeedParams(
        body: GetPostsBody(
          country: settings.country,
          pagination: GetPostsPaginationModel(
            perPage: perPage,
            offset: page * perPage,
          ),
        ),
        userId: user.id,
      ));

      result.map(success: (success) {
        newPosts.addAll(success.response.posts);
        canLoadMore = success.response.pagination.count % perPage == 0;
      }, failure: (failure) {
        emit(FeedState.error(failure.message));
      });
    }

    state.maybeMap(
        loaded: (loaded) {
          final posts = loaded.posts.toList();
          posts.addAll(newPosts);

          emit(
            FeedState.loaded(posts, false, canLoadMore),
          );
        },
        loading: (loading) {
          emit(
            FeedState.loaded(newPosts, false, canLoadMore),
          );
        },
        orElse: () {});

    loading = false;
  }

  Future<void> _onReloadFeed(
    ReloadFeed event,
    Emitter<FeedState> emit,
  ) async {
    if (event.wait) {
      await Future.delayed(const Duration(milliseconds: 400));
    }
    page = 0;
    emit(const FeedState.loading());
    add(const GetFeed());
  }

  Future<void> _onLoadMore(
    LoadMore event,
    Emitter<FeedState> emit,
  ) async {
    if (loading) {
      return;
    }
    var shouldReturn = false;
    loading = true;

    Posthog().capture(eventName: 'feed_load_more', properties: {
      'page': page,
    });
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
    add(const GetFeed());
  }
}
