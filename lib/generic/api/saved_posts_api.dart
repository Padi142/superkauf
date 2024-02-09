import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';
import 'package:superkauf/generic/saved_posts/model/saved_post_model.dart';

part 'saved_posts_api.g.dart';

@RestApi()
abstract class SavedPostsApi {
  factory SavedPostsApi(Dio dio) = _SavedPostsApi;

  @GET('/saved_posts/{id}?per_page={perPage}&offset={offset}')
  Future<GetPaginatedPostsResponseModel> getUserSavedPosts({
    @Path() required int id,
    @Path() required int perPage,
    @Path() required int offset,
  });

  @POST('/saved_posts')
  Future<SavedPostModel> createSavedPost({
    @Body() required Map<String, dynamic> body,
  });

  @DELETE('/saved_posts')
  Future<SavedPostModel> deleteSavedPost({
    @Body() required Map<String, dynamic> body,
  });

  @PUT('/saved_posts')
  Future<SavedPostModel> updateSavedPost({
    @Body() required Map<String, dynamic> body,
  });
}
