import 'package:superkauf/generic/saved_posts/data/saved_posts_repository.dart';
import 'package:superkauf/generic/saved_posts/model/create_saved_post_body.dart';
import 'package:superkauf/generic/saved_posts/model/create_saved_post_result.dart';
import 'package:superkauf/library/use_case.dart';

class CreateSavedPostUseCase extends UseCase<CreateSavedPostResult, CreateSavedPostBody> {
  SavedPostsRepository repository;

  CreateSavedPostUseCase({
    required this.repository,
  });

  @override
  Future<CreateSavedPostResult> call(params) async {
    return await repository.createSavedPost(params);
  }
}
