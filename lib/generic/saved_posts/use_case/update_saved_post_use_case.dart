import 'package:superkauf/generic/saved_posts/data/saved_posts_repository.dart';
import 'package:superkauf/generic/saved_posts/model/get_saved_post_result.dart';
import 'package:superkauf/generic/saved_posts/model/update_saved_post_body.dart';
import 'package:superkauf/library/use_case.dart';

class UpdateSavedPostUseCase
    extends UseCase<GetSavedPostResult, UpdateSavedPostBody> {
  SavedPostsRepository repository;

  UpdateSavedPostUseCase({
    required this.repository,
  });

  @override
  Future<GetSavedPostResult> call(params) async {
    return await repository.updateSavedPost(params);
  }
}
