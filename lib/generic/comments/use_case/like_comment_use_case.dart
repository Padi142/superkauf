import 'package:superkauf/generic/comments/data/comments_reository.dart';
import 'package:superkauf/generic/comments/model/get_comments_result.dart';
import 'package:superkauf/generic/comments/model/like_comment_body.dart';
import 'package:superkauf/library/use_case.dart';

class LikeCommentUseCase extends UseCase<GetCommentsResult, LikeCommentBody> {
  CommentsRepository repository;

  LikeCommentUseCase({
    required this.repository,
  });

  @override
  Future<GetCommentsResult> call(params) async {
    return await repository.likeComment(params);
  }
}
