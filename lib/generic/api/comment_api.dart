import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:superkauf/generic/comments/model/comment_model.dart';
import 'package:superkauf/generic/comments/model/post_comment_model.dart';

part 'comment_api.g.dart';

@RestApi()
abstract class CommentApi {
  factory CommentApi(Dio dio) = _CommentApi;

  @POST('/comment')
  Future<CommentModel> createComment({
    @Body() required Map<String, dynamic> body,
  });

  @DELETE('/comment')
  Future<CommentModel> deleteComment({
    @Body() required Map<String, dynamic> body,
  });

  @GET('/post/{id}/comments')
  Future<List<PostCommentModel>> getCommentsForPost({
    @Path() required int id,
  });
}
