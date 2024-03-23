import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:superkauf/generic/notifications/model/models/notification_model.dart';
import 'package:superkauf/generic/notifications/user_case/get_notifications_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

import 'my_notifications_state.dart';

part 'my_notifications_event.dart';

class MyNotificationsBloc extends Bloc<MyNotificationsEvent, MyNotificationsState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetNotificationsUseCase getNotificationsUseCase;

  MyNotificationsBloc({
    required this.getCurrentUserUseCase,
    required this.getNotificationsUseCase,
  }) : super(const MyNotificationsState.loading()) {
    on<GetNotifications>(_onGetNotifications);
    on<LoadMore>(_onLoadMore);
    on<ReloadNotifications>(_onReloadNotifications);
  }

  var userId = -1;
  var page = 0;
  static const limit = 15;
  var loading = false;

  Future<void> _onGetNotifications(
    GetNotifications event,
    Emitter<MyNotificationsState> emit,
  ) async {
    final List<NotificationModel> newPosts = [];
    var canLoadMore = false;
    final user = await getCurrentUserUseCase.call(false);

    if (user == null) {
      emit(const MyNotificationsState.error("You are not logged in"));
      return;
    }

    //Load feed for not-logged user
    final result = await getNotificationsUseCase.call((
      userId: user.id,
      page: page,
      limit: limit,
    ));

    result.map(success: (success) {
      newPosts.addAll(success.notifications);
      canLoadMore = success.notifications.length % limit == 0;
    }, failure: (failure) {
      emit(MyNotificationsState.error(failure.message));
    });

    state.maybeMap(
        loaded: (loaded) {
          final posts = loaded.notifications.toList();
          posts.addAll(newPosts);

          emit(
            MyNotificationsState.loaded(posts, false, canLoadMore),
          );
        },
        loading: (loading) {
          emit(
            MyNotificationsState.loaded(newPosts, false, canLoadMore),
          );
        },
        orElse: () {});

    loading = false;
  }

  Future<void> _onLoadMore(
    LoadMore event,
    Emitter<MyNotificationsState> emit,
  ) async {
    if (loading) {
      return;
    }
    var shouldReturn = false;
    loading = true;

    Posthog().capture(eventName: 'notifications_load_more', properties: {
      'page': page,
    });
    state.maybeMap(
      loaded: (loaded) {
        if (loaded.notifications.length % limit == 0) {
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
    add(const GetNotifications());
  }

  Future<void> _onReloadNotifications(
    ReloadNotifications event,
    Emitter<MyNotificationsState> emit,
  ) async {
    if (event.wait) {
      await Future.delayed(const Duration(milliseconds: 400));
    }
    page = 0;
    emit(const MyNotificationsState.loading());
    add(const GetNotifications());
  }
}
