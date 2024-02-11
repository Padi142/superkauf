import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/feature/user_detail/bloc/user_detail_state.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';
import 'package:superkauf/generic/post/model/get_posts_body.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';
import 'package:superkauf/generic/post/model/pagination_model.dart';
import 'package:superkauf/generic/post/use_case/get_posts_by_user.dart';
import 'package:superkauf/generic/settings/use_case/get_settings_use_case.dart';
import 'package:superkauf/generic/user/model/user_model.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_id_use_case.dart';

part 'user_detail_event.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final GetUserByIdUseCase getUserByIdUseCase;
  final GetPostsByUserUseCase getPostsByUserUseCase;
  final GetSettingsUseCase getSettingsUseCase;

  UserDetailBloc({
    required this.getUserByIdUseCase,
    required this.getPostsByUserUseCase,
    required this.getSettingsUseCase,
  }) : super(const UserDetailState.loading()) {
    on<GetUser>(_onGetUser);
    on<InitialUserEvent>(_onInitialUserEvent);
    on<LoadMore>(_onLoadMore);
    on<ReloadUser>(_onReloadUser);
  }

  var page = 0;
  var loading = false;
  static const perPage = 15;

  var userId = 0;

  Future<void> _onGetUser(
    GetUser event,
    Emitter<UserDetailState> emit,
  ) async {
    late UserModel user;

    if (userId != event.userID) {
      page = 0;
      emit(const UserDetailState.loading());
    }
    userId = event.userID;

    final result = await getUserByIdUseCase.call(event.userID);

    final List<FeedPostModel> newPosts = [];
    var canLoadMore = false;

    final settings = await getSettingsUseCase.call();

    final params = GetPersonalFeedParams(
      body: GetPostsBody(
        country: settings.country,
        pagination: GetPostsPaginationModel(
          perPage: perPage,
          offset: page * perPage,
        ),
      ),
      userId: event.userID,
    );

    final postsResult = await getPostsByUserUseCase.call(params);

    result.map(success: (success) {
      user = success.user;
    }, failure: (failure) {
      emit(UserDetailState.error(failure.message));
    });

    postsResult.map(success: (success) {
      newPosts.addAll(success.response.posts);
      canLoadMore = success.response.posts.length % perPage == 0;
    }, failure: (failure) {
      emit(UserDetailState.error(failure.message));
    });

    state.maybeMap(
        loaded: (loaded) {
          final posts = loaded.posts.toList();
          posts.addAll(newPosts);

          emit(
            UserDetailState.loaded(user, posts, false, canLoadMore),
          );
        },
        loading: (loading) {
          emit(
            UserDetailState.loaded(user, newPosts, false, canLoadMore),
          );
        },
        orElse: () {});

    loading = false;
  }

  Future<void> _onInitialUserEvent(
    InitialUserEvent event,
    Emitter<UserDetailState> emit,
  ) async {
    emit(UserDetailState.initial(event.user));
    add(GetUser(userID: event.user.id));
  }

  Future<void> _onLoadMore(
    LoadMore event,
    Emitter<UserDetailState> emit,
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
    add(GetUser(userID: userId));
  }

  Future<void> _onReloadUser(
    ReloadUser event,
    Emitter<UserDetailState> emit,
  ) async {
    page = 0;

    emit(const UserDetailState.loading());
    add(GetUser(userID: userId));
  }
}
