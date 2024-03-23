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

  @POST('/feed?country={country}')
  Future<GetPostsResponseModel> getFeed({
    @Body() required Map<String, dynamic> body,
    @Path() required String country,
  });

  @POST('/feed/{id}?country={country}')
  Future<GetPaginatedPostsResponseModel> getPersonalFeed({
    @Body() required Map<String, dynamic> body,
    @Path() required int id,
    @Path() required String country,
  });

  @POST('/post')
  Future<PostModel> createPost({
    @Header('Authorization') required String token,
    @Body() required Map<String, dynamic> body,
  });

  @DELETE('/post')
  Future<PostModel> deletePost({
    @Header('Authorization') required String token,
    @Body() required Map<String, dynamic> body,
  });

  @GET('/post/{id}?userId={userId}')
  Future<FullContextPostModel> getPostById({
    @Path() required String id,
    @Path() required int userId,
  });

  @GET('/user/posts/{id}?offset={offset}&per_page={per_page}')
  Future<List<FeedPostModel>> getPostsByUser({
    @Path() required String id,
    @Path() required int per_page,
    @Path() required int offset,
  });

  @PUT('/post/image')
  Future<PostModel> updatePostImage({
    @Header('Authorization') required String token,
    @Body() required Map<String, dynamic> body,
  });

  @PUT('/post?field={field}')
  Future<PostModel> updatePostContent({
    @Header('Authorization') required String token,
    @Body() required Map<String, dynamic> body,
    @Path() required String field,
  });

  @POST('/post/{id}/add_reaction')
  Future<ReactionModel> addReaction({
    @Header('Authorization') required String token,
    @Path() required String id,
    @Body() required Map<String, dynamic> body,
  });

  @POST('/post/{id}/remove_reaction')
  Future<ReactionModel> removeReaction({
    @Header('Authorization') required String token,
    @Path() required String id,
    @Body() required Map<String, dynamic> body,
  });

  @GET('/feed/top?offset={offset}&per_page={per_page}&userId={userId}&timeRange={timeRange}&country={country}&store={store}')
  Future<GetPaginatedPostsResponseModel> getTopPosts({
    @Path() required int per_page,
    @Path() required int offset,
    @Path() required int userId,
    @Path() required String timeRange,
    @Path() required String country,
    @Path() int? store,
  });
}
