import 'package:superkauf/generic/post/data/post_repository.dart';
import 'package:superkauf/generic/post/model/get_posts_body.dart';
import 'package:superkauf/generic/post/model/get_posts_result.dart';
import 'package:superkauf/library/use_case.dart';

class GetPostsUseCase extends UseCase<GetPostsResult, GetPostsBody> {
  PostsRepository repository;

  GetPostsUseCase({
    required this.repository,
  });

  @override
  Future<GetPostsResult> call(params) async {
    return await repository.getPosts(params);
  }
}
