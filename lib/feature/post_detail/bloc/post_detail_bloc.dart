import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_state.dart';
import 'package:superkauf/generic/post/model/post_model.dart';
import 'package:superkauf/generic/post/model/results/get_post_detail_params.dart';
import 'package:superkauf/generic/post/use_case/get_post_detail_use_case.dart';
import 'package:superkauf/generic/user/model/user_model.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

part 'post_detail_event.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final GetPostDetailUseCase getPostDetailUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  PostDetailBloc({
    required this.getPostDetailUseCase,
    required this.getCurrentUserUseCase,
  }) : super(const PostDetailState.loading()) {
    on<InitialEvent>(_onInitialEvent);
    on<GetPost>(_onGetPost);
    on<ReloadPost>(_onReloadPost);
  }

  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<PostDetailState> emit,
  ) async {
    emit(PostDetailState.initial(event.post, event.user));
    add(GetPost(postId: event.post.id.toString()));
  }

  Future<void> _onGetPost(
    GetPost event,
    Emitter<PostDetailState> emit,
  ) async {
    var canEdit = false;
    final userResult = await getCurrentUserUseCase.call();

    final params =
        GetPostDetailParams(postId: event.postId, userId: userResult?.id ?? 0);

    final result = await getPostDetailUseCase.call(params);

    result.map(success: (success) {
      if (userResult != null) {
        if (userResult.id == success.post.post.author || userResult.isAdmin) {
          canEdit = true;
        }
      }

      emit(const PostDetailState.loading());
      emit(PostDetailState.loaded(success.post.post,
          success.post.reaction != null, success.post.user, canEdit));
    }, failure: (failure) {
      print(failure.message);
      emit(PostDetailState.error(failure.message));
    });
  }

  Future<void> _onReloadPost(
    ReloadPost event,
    Emitter<PostDetailState> emit,
  ) async {
    emit(const PostDetailState.loading());
    if (event.wait) {
      Future.delayed(const Duration(milliseconds: 600));
    }
    add(GetPost(postId: event.postId));
  }
}
