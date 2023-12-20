import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_state.freezed.dart';

@freezed
abstract class CreatePostState with _$CreatePostState {
  const factory CreatePostState.loading() = Loading;

  const factory CreatePostState.initial() = Initial;

  const factory CreatePostState.uploading() = Uploading;

  const factory CreatePostState.imageUploaded(String image) = ImageUploaded;

  // const factory CreatePostState.success(PostModel post) = Success;
  const factory CreatePostState.success() = Success;

  const factory CreatePostState.error(String error) = Error;
}
