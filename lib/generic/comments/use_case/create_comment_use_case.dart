import 'package:superkauf/generic/comments/data/comments_reository.dart';
import 'package:superkauf/generic/comments/model/create_comment_body.dart';
import 'package:superkauf/generic/comments/model/get_comments_result.dart';
import 'package:superkauf/library/use_case.dart';

class CreateCommentUseCase extends UseCase<GetCommentsResult, CreateCommentBody> {
  CommentsRepository repository;

  CreateCommentUseCase({
    required this.repository,
  });

  @override
  Future<GetCommentsResult> call(params) async {
    return await repository.createComment(params);
  }
}
