import 'package:superkauf/generic/post/data/post_repository.dart';
import 'package:superkauf/generic/post/model/get_posts_result.dart';
import 'package:superkauf/generic/post/model/pagination_model.dart';
import 'package:superkauf/library/use_case.dart';

class GetPostsUseCase extends UseCase<GetPostsResult, GetPostsPaginationModel> {
  PostsRepository repository;

  GetPostsUseCase({
    required this.repository,
  });

  @override
  Future<GetPostsResult> call(params) async {
    return await repository.getPosts(params);
  }
}
