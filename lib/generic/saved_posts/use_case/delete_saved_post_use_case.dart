import 'package:superkauf/generic/saved_posts/data/saved_posts_repository.dart';
import 'package:superkauf/generic/saved_posts/model/delete_saved_post_body.dart';
import 'package:superkauf/generic/saved_posts/model/delete_saved_post_model.dart';
import 'package:superkauf/library/use_case.dart';

class DeleteSavedPostUseCase extends UseCase<DeleteSavedPostResult, DeleteSavedPostBody> {
  SavedPostsRepository repository;

  DeleteSavedPostUseCase({
    required this.repository,
  });

  @override
  Future<DeleteSavedPostResult> call(params) async {
    return await repository.deleteSavedPost(params);
  }
}
