import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';

part 'feed_state.freezed.dart';

@freezed
abstract class FeedState with _$FeedState {
  const factory FeedState.loading() = Loading;

  const factory FeedState.loaded(
    List<FeedPostModel> posts,
    List<FeedPersonalPostModel> personalPosts,
    bool isPersonal,
    bool isLoading,
    bool canLoadMore,
  ) = Loaded;

  const factory FeedState.error(String error) = Error;
}
