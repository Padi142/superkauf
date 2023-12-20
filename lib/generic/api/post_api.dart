import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';
import 'package:superkauf/generic/post/model/post_model.dart';

part 'post_api.g.dart';

@RestApi()
abstract class PostApi {
  factory PostApi(Dio dio) = _PostApi;

  @GET('/feed')
  Future<List<FeedPostModel>> getFeed();

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
}
