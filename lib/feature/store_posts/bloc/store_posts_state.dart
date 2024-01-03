import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';

part 'store_posts_state.freezed.dart';

@freezed
abstract class StorePostsState with _$StorePostsState {
  const factory StorePostsState.loading() = Loading;

  const factory StorePostsState.loaded(
    List<FullContextPostModel> posts,
    bool isLoading,
    bool canLoadMore,
  ) = Loaded;

  const factory StorePostsState.error(String error) = Error;
}
