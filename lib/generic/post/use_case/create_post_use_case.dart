import 'package:superkauf/generic/post/data/post_repository.dart';
import 'package:superkauf/generic/post/model/create_post_model.dart';
import 'package:superkauf/generic/post/model/create_post_result.dart';
import 'package:superkauf/library/use_case.dart';

class CreatePostUseCase extends UseCase<CreatePostResult, CreatePostModel> {
  PostsRepository repository;

  CreatePostUseCase({
    required this.repository,
  });

  @override
  Future<CreatePostResult> call(params) async {
    return await repository.createPost(params);
  }
}
