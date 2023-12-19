import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/post_model.dart';

part 'create_post_result.freezed.dart';

@freezed
class CreatePostResult with _$CreatePostResult {
  const factory CreatePostResult.success(PostModel post) = Success;

  const factory CreatePostResult.failure(String message) = Failure;
}
