import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';
import 'package:superkauf/generic/post/model/pagination_model.dart';
import 'package:superkauf/generic/post/use_case/get_posts_by_user.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_uid_use_case.dart';

import 'my_channel_state.dart';

part 'my_channel_event.dart';

class MyChannelBloc extends Bloc<MyChannelEvent, MyChannelState> {
  final GetPostsByUserUseCase getPostsByUserUseCase;
  final GetUserByUidUseCase getUserByUidUseCase;

  MyChannelBloc({
    required this.getPostsByUserUseCase,
    required this.getUserByUidUseCase,
  }) : super(const MyChannelState.loading()) {
    on<GetPosts>(_onGetPosts);
  }

  var userId = -1;

  Future<void> _onGetPosts(
    GetPosts event,
    Emitter<MyChannelState> emit,
  ) async {
    emit(const MyChannelState.loading());

    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) {
      emit(const MyChannelState.error('User not found'));
      return;
    }

    final userResult = await getUserByUidUseCase.call(user.id);
    userResult.when(
      success: (success) {
        userId = success.id;
      },
      failure: (message) {
        emit(MyChannelState.error(message));
        return;
      },
    );

    final params = GetPersonalFeedParams(
      pagination: const GetPostsPaginationModel(
        perPage: 15,
        offset: 0,
      ),
      userId: userId,
    );

    final result = await getPostsByUserUseCase.call(params);
    result.when(
      success: (success) {
        emit(MyChannelState.loaded(success.posts));
      },
      failure: (message) {
        emit(MyChannelState.error(message));
      },
    );
  }
}
