import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';
import 'package:superkauf/generic/post/model/post_model.dart';

part 'store_posts_state.freezed.dart';

@freezed
abstract class StorePostsState with _$StorePostsState {
  const factory StorePostsState.loading() = Loading;

  const factory StorePostsState.loaded(List<FeedPostModel> posts) = Loaded;

  const factory StorePostsState.error(String error) = Error;
}
