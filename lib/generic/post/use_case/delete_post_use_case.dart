import 'package:superkauf/generic/post/data/post_repository.dart';
import 'package:superkauf/generic/post/model/delete_post_body.dart';
import 'package:superkauf/generic/post/model/delete_post_result.dart';
import 'package:superkauf/library/use_case.dart';

class DeletePostUseCase extends UseCase<DeletePostResult, DeletePostBody> {
  PostsRepository repository;

  DeletePostUseCase({
    required this.repository,
  });

  @override
  Future<DeletePostResult> call(params) async {
    return await repository.deletePost(params);
  }
}
