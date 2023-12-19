import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/feature/feed/bloc/feed_state.dart';
import 'package:superkauf/generic/post/use_case/get_posts_use_case.dart';

part 'feed_event.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetPostsUseCase getPostsUseCase;

  FeedBloc({
    required this.getPostsUseCase,
  }) : super(const FeedState.loading()) {
    on<GetFeed>(_onGetFeed);
    on<ReloadFeed>(_onReloadFeed);
  }

  Future<void> _onGetFeed(
    GetFeed event,
    Emitter<FeedState> emit,
  ) async {
    final result = await getPostsUseCase.call();

    result.map(success: (success) {
      emit(FeedState.loaded(success.posts));
    }, failure: (failure) {
      emit(FeedState.error(failure.message));
    });
  }

  Future<void> _onReloadFeed(
    ReloadFeed event,
    Emitter<FeedState> emit,
  ) async {
    if (event.wait) {
      await Future.delayed(const Duration(milliseconds: 400));
    }
    add(const GetFeed());
  }
}
