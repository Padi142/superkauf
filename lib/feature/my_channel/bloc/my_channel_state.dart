import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';

part 'my_channel_state.freezed.dart';

@freezed
abstract class MyChannelState with _$MyChannelState {
  const factory MyChannelState.loading() = Loading;

  const factory MyChannelState.loaded(List<FeedPostModel> posts) = Loaded;

  const factory MyChannelState.error(String error) = Error;
}
