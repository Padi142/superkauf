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
    on<ReloadStorePosts>(_onReloadStorePosts);
  }
  var storeId = -1;

  Future<void> _onGetPosts(
    GetPosts event,
    Emitter<StorePostsState> emit,
  ) async {
    emit(const StorePostsState.loading());
    storeId = event.storeId;

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

  Future<void> _onReloadStorePosts(
    ReloadStorePosts event,
    Emitter<StorePostsState> emit,
  ) async {
    if (event.wait) {
      await Future.delayed(const Duration(milliseconds: 400));
    }
    emit(const StorePostsState.loading());
    add(GetPosts(storeId: storeId));
  }
}
