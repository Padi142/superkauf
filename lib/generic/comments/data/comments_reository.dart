import 'package:dio/dio.dart';
import 'package:superkauf/generic/api/comment_api.dart';
import 'package:superkauf/generic/comments/model/create_comment_body.dart';
import 'package:superkauf/generic/comments/model/delete_comment_body.dart';
import 'package:superkauf/generic/comments/model/get_comments_for_post_result.dart';
import 'package:superkauf/generic/comments/model/get_comments_result.dart';
import 'package:superkauf/generic/comments/model/like_comment_body.dart';

class CommentsRepository {
  final CommentApi commentApi;

  CommentsRepository({
    required this.commentApi,
  });

  Future<GetCommentsResult> deleteComment(DeleteCommentBody body) async {
    return commentApi.deleteComment(body: body.toJson()).then((comment) {
      return GetCommentsResult.success([comment]);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetCommentsResult.failure(error.message ?? 'error deleting comment');
      }
      return const GetCommentsResult.failure('error');
    });
  }

  Future<GetCommentsResult> createComment(CreateCommentBody body) async {
    return commentApi.createComment(body: body.toJson()).then((comment) {
      return GetCommentsResult.success([comment]);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetCommentsResult.failure(error.message ?? 'error creating comment');
      }
      return const GetCommentsResult.failure('error');
    });
  }

  Future<GetCommentsResult> likeComment(LikeCommentBody body) async {
    return commentApi.likeComment(body: body.toJson()).then((comment) {
      return GetCommentsResult.success([comment]);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetCommentsResult.failure(error.message ?? 'error deleting comment');
      }
      return const GetCommentsResult.failure('error');
    });
  }

  Future<GetCommentsForPostResult> getCommentsForPost(int postId) async {
    return commentApi.getCommentsForPost(id: postId).then((comments) {
      return GetCommentsForPostResult.success(comments);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetCommentsForPostResult.failure(error.message ?? 'error getting deleting comment');
      }
      return const GetCommentsForPostResult.failure('error');
    });
  }
}
