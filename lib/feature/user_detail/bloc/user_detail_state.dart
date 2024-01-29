import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';
import 'package:superkauf/generic/user/model/user_model.dart';

part 'user_detail_state.freezed.dart';

@freezed
abstract class UserDetailState with _$UserDetailState {
  const factory UserDetailState.loading() = Loading;

  const factory UserDetailState.initial(UserModel user) = Initial;

  const factory UserDetailState.loaded(UserModel user, List<FeedPostModel> posts) = Loaded;

  const factory UserDetailState.error(String error) = Error;
}
