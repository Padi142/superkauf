import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/generic/post/bloc/post_state.dart';
import 'package:superkauf/generic/post/model/delete_post_body.dart';
import 'package:superkauf/generic/post/use_case/delete_post_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_uid_use_case.dart';

part 'post_event.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final DeletePostUseCase deletePostUseCase;
  final GetUserByUidUseCase getUserByUidUseCase;

  PostBloc({
    required this.deletePostUseCase,
    required this.getUserByUidUseCase,
  }) : super(const PostState.loading()) {
    on<DeletePost>(_onDeletePost);
  }

  Future<void> _onDeletePost(
    DeletePost event,
    Emitter<PostState> emit,
  ) async {
    emit(const PostState.loading());
    var userId = -1;

    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) {
      emit(const PostState.error("You are not logged in"));
      return;
    }

    final userResult = await getUserByUidUseCase.call(user.id);
    userResult.map(
      success: (success) {
        if (success.user.id != event.author && !success.user.isAdmin) {
          emit(const PostState.error("You are not the author of this post"));
          return;
        }
        userId = success.user.id;
      },
      failure: (failure) {
        emit(const PostState.error("You probably dont exist :/// "));
        return;
      },
    );

    final params = DeletePostBody(postId: event.postId, author: userId.toString());

    final result = await deletePostUseCase.call(params);
    result.when(
      success: () {
        emit(const PostState.success());
      },
      failure: (message) {
        emit(PostState.error(message));
      },
    );
  }
}
