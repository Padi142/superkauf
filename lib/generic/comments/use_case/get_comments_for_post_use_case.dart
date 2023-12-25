import 'package:superkauf/generic/comments/data/comments_reository.dart';
import 'package:superkauf/generic/comments/model/get_comments_for_post_result.dart';
import 'package:superkauf/library/use_case.dart';

class GetCommentsForPostUseCase extends UseCase<GetCommentsForPostResult, int> {
  CommentsRepository repository;

  GetCommentsForPostUseCase({
    required this.repository,
  });

  @override
  Future<GetCommentsForPostResult> call(params) async {
    return await repository.getCommentsForPost(params);
  }
}
