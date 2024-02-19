import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_state.freezed.dart';

@freezed
abstract class CreatePostState with _$CreatePostState {
  const factory CreatePostState.loading() = Loading;

  const factory CreatePostState.initial({
    required bool canUploadFiles,
    required int requiredKarma,
  }) = Initial;

  const factory CreatePostState.imagePicked(File image) = ImagePicked;

  const factory CreatePostState.uploading() = Uploading;

  const factory CreatePostState.creating() = Creating;

  const factory CreatePostState.imageUploaded(String image) = ImageUploaded;

  // const factory CreatePostState.success(PostModel post) = Success;
  const factory CreatePostState.success() = Success;

  const factory CreatePostState.error(String error) = Error;
}
