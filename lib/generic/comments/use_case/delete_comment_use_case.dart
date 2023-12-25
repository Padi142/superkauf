import 'package:superkauf/generic/comments/data/comments_reository.dart';
import 'package:superkauf/generic/comments/model/delete_comment_body.dart';
import 'package:superkauf/generic/comments/model/get_comments_result.dart';
import 'package:superkauf/library/use_case.dart';

class DeleteCommentUseCase
    extends UseCase<GetCommentsResult, DeleteCommentBody> {
  CommentsRepository repository;

  DeleteCommentUseCase({
    required this.repository,
  });

  @override
  Future<GetCommentsResult> call(params) async {
    return await repository.deleteComment(params);
  }
}
