import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/feature/store_posts/bloc/store_posts_state.dart';
import 'package:superkauf/generic/store/use_case/get_posts_by_store_use_case.dart';

part 'store_posts_event.dart';

class StorePostsBloc extends Bloc<StorePostsEvent, StorePostsState> {
  final GetPostsByStoreUseCase getPostsByStoreUseCase;

  StorePostsBloc({
    required this.getPostsByStoreUseCase,
  }) : super(const StorePostsState.loading()) {
    on<GetPosts>(_onGetPosts);
  }

  Future<void> _onGetPosts(
    GetPosts event,
    Emitter<StorePostsState> emit,
  ) async {
    emit(const StorePostsState.loading());

    final result = await getPostsByStoreUseCase.call(event.storeId);
    result.when(
      success: (success) {
        emit(StorePostsState.loaded(success));
      },
      failure: (message) {
        emit(StorePostsState.error(message));
      },
    );
  }
}
