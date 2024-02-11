import 'package:superkauf/generic/post/data/post_repository.dart';
import 'package:superkauf/generic/post/model/get_posts_result.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';
import 'package:superkauf/library/use_case.dart';

class GetPostsByUserUseCase extends UseCase<GetPostsResult, GetPersonalFeedParams> {
  PostsRepository repository;

  GetPostsByUserUseCase({
    required this.repository,
  });

  @override
  Future<GetPostsResult> call(params) async {
    return await repository.getPostsByUser(params.body.pagination, params.userId);
  }
}
