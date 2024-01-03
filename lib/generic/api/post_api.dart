import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';
import 'package:superkauf/generic/post/model/models/reaction_model.dart';
import 'package:superkauf/generic/post/model/post_model.dart';

part 'post_api.g.dart';

@RestApi()
abstract class PostApi {
  factory PostApi(Dio dio) = _PostApi;

  @POST('/feed')
  Future<GetPostsResponseModel> getFeed({
    @Body() required Map<String, dynamic> body,
  });

  @POST('/feed/{id}')
  Future<GetPaginatedPostsResponseModel> getPersonalFeed({
    @Body() required Map<String, dynamic> body,
    @Path() required int id,
  });

  @POST('/post')
  Future<PostModel> createPost({
    @Body() required Map<String, dynamic> body,
  });

  @DELETE('/post')
  Future<PostModel> deletePost({
    @Body() required Map<String, dynamic> body,
  });

  @GET('/post/{id}')
  Future<PostModel> getPostById({
    @Path() required String id,
  });

  @GET('/user/posts/{id}')
  Future<List<FeedPostModel>> getPostsByUser({
    @Path() required String id,
  });

  @PUT('/post/image')
  Future<PostModel> updatePostImage({
    @Body() required Map<String, dynamic> body,
  });

  @PUT('/post')
  Future<PostModel> updatePostContent({
    @Body() required Map<String, dynamic> body,
  });

  @POST('/post/{id}/add_reaction')
  Future<ReactionModel> addReaction({
    @Path() required String id,
    @Body() required Map<String, dynamic> body,
  });

  @POST('/post/{id}/remove_reaction')
  Future<ReactionModel> removeReaction({
    @Path() required String id,
    @Body() required Map<String, dynamic> body,
  });
}
