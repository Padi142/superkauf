import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:superkauf/generic/post/model/get_posts_body.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';
import 'package:superkauf/generic/post/model/pagination_model.dart';
import 'package:superkauf/generic/post/use_case/get_top_posts_use_case.dart';
import 'package:superkauf/generic/settings/use_case/get_settings_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

import 'discover_state.dart';

part 'discover_event.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final GetTopPostsUseCase getTopPostsUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetSettingsUseCase getSettingsUseCase;

  DiscoverBloc({
    required this.getTopPostsUseCase,
    required this.getCurrentUserUseCase,
    required this.getSettingsUseCase,
  }) : super(const DiscoverState.loading()) {
    on<GetTopPosts>(_onGetTopPosts);
    on<LoadMore>(_onLoadMore);
    on<ReloadPosts>(_onReloadPosts);
    on<ChangeTimeRange>(_onChangeTimeRange);
  }

  var page = 0;
  var loading = false;
  static const perPage = 5;

  var sortBy = SortType.top;
  var timeRange = TimeRange.week;

  Future<void> _onGetTopPosts(
    GetTopPosts event,
    Emitter<DiscoverState> emit,
  ) async {
    final List<FullContextPostModel> newPosts = [];

    final user = await getCurrentUserUseCase.call();

    final settings = await getSettingsUseCase.call();

    final params = GetTopPostsParams(
        userId: user?.id ?? 0,
        body: GetPostsBody(
          pagination: GetPostsPaginationModel(
            offset: page * perPage,
            perPage: perPage,
          ),
          country: settings.country,
        ),
        timeRange: timeRange.name,
        sortBy: '');

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
            DiscoverState.loaded(posts, false, canLoadMore, sortBy, timeRange),
          );
        },
        loading: (loading) {
          final canLoadMore = newPosts.length % perPage == 0;

          emit(
            DiscoverState.loaded(newPosts, false, canLoadMore, sortBy, timeRange),
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

  Future<void> _onChangeTimeRange(
    ChangeTimeRange event,
    Emitter<DiscoverState> emit,
  ) async {
    page = 0;
    timeRange = event.timeRange;

    Posthog().capture(eventName: 'discover_sort', properties: {
      'sortType': sortBy.name,
      'timeRange': timeRange.name,
    });

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
    //
    // final pepici = ['Jarda', 'Stanislav', 'Ondřej', 'František'];
    //
    // for (final pepa in pepici) {
    //   print("$pepa je pepa :---DDD");
    // }
  }
}

enum SortType {
  top,
}

extension SortTypeExtension on SortType {
  String get name {
    switch (this) {
      case SortType.top:
        return 'top';
    }
  }
}

enum TimeRange {
  day,
  week,
  month,
  year,
  all,
}

extension TimeRangeExtension on TimeRange {
  String get name {
    switch (this) {
      case TimeRange.day:
        return 'day';
      case TimeRange.week:
        return 'week';
      case TimeRange.month:
        return 'month';
      case TimeRange.year:
        return 'year';
      case TimeRange.all:
        return 'all';
    }
  }
}
