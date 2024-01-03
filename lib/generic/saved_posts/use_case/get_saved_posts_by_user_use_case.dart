import 'package:superkauf/generic/saved_posts/data/saved_posts_repository.dart';
import 'package:superkauf/generic/saved_posts/model/get_saved_post_params.dart';
import 'package:superkauf/generic/saved_posts/model/get_saved_posts_result.dart';
import 'package:superkauf/library/use_case.dart';

class GetSavedPostsByUserUseCase extends UseCase<GetSavedPostsResult, GetSavedPostsParams> {
  SavedPostsRepository repository;

  GetSavedPostsByUserUseCase({
    required this.repository,
  });

  @override
  Future<GetSavedPostsResult> call(params) async {
    return await repository.getSavedPosts(params);
  }
}
