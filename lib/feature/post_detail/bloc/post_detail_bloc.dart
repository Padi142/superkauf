import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_state.dart';
import 'package:superkauf/generic/post/model/post_model.dart';
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
  }

  late UserModel author;

  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<PostDetailState> emit,
  ) async {
    author = event.user;
    emit(PostDetailState.initial(event.post, author));
    add(GetPost(postId: event.post.id.toString()));
  }

  Future<void> _onGetPost(
    GetPost event,
    Emitter<PostDetailState> emit,
  ) async {
    var canEdit = false;
    final result = await getPostDetailUseCase.call(event.postId);
    final userResult = await getCurrentUserUseCase.call();

    result.map(success: (success) {
      if (userResult != null) {
        if (userResult.id == success.post.author || userResult.isAdmin) {
          canEdit = true;
        }
      }

      emit(PostDetailState.loaded(success.post, author, canEdit));
    }, failure: (failure) {
      print(failure.message);
      emit(PostDetailState.error(failure.message));
    });
  }
}
