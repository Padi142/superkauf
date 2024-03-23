import 'package:superkauf/generic/post/data/post_repository.dart';
import 'package:superkauf/generic/post/model/get_post_detail_result.dart';
import 'package:superkauf/generic/post/model/update_post_image_body.dart';
import 'package:superkauf/library/use_case.dart';

class UpdatePostImageUseCase extends UseCase<GetPostDetailResult, ({UpdatePostImageBody model, String token})> {
  PostsRepository repository;

  UpdatePostImageUseCase({
    required this.repository,
  });

  @override
  Future<GetPostDetailResult> call(params) async {
    return await repository.updatePostImage(params.model, params.token);
  }
}
