import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/generic/post/bloc/post_state.dart';
import 'package:superkauf/generic/post/model/delete_post_body.dart';
import 'package:superkauf/generic/post/use_case/delete_post_use_case.dart';

part 'post_event.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final DeletePostUseCase deletePostUseCase;

  PostBloc({
    required this.deletePostUseCase,
  }) : super(const PostState.loading()) {
    on<DeletePost>(_onGetFeed);
  }

  Future<void> _onGetFeed(
    DeletePost event,
    Emitter<PostState> emit,
  ) async {
    emit(const PostState.loading());

    final params = DeletePostBody(postId: event.postId, author: '1');

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
