import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/post_model.dart';
import 'package:superkauf/generic/user/model/user_model.dart';

part 'post_detail_state.freezed.dart';

@freezed
abstract class PostDetailState with _$PostDetailState {
  const factory PostDetailState.loading() = Loading;

  const factory PostDetailState.initial(PostModel post, UserModel user) = Initial;

  const factory PostDetailState.loaded(PostModel post, UserModel user, bool canEdit) = Loaded;

  const factory PostDetailState.error(String error) = Error;
}
