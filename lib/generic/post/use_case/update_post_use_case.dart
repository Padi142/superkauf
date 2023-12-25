import 'package:superkauf/generic/post/data/post_repository.dart';
import 'package:superkauf/generic/post/model/get_post_detail_result.dart';
import 'package:superkauf/generic/post/model/update_post_body.dart';
import 'package:superkauf/library/use_case.dart';

class UpdatePostUseCase extends UseCase<GetPostDetailResult, UpdatePostBody> {
  PostsRepository repository;

  UpdatePostUseCase({
    required this.repository,
  });

  @override
  Future<GetPostDetailResult> call(params) async {
    return await repository.updatePostContent(params);
  }
}
