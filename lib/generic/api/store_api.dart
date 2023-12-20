import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';
import 'package:superkauf/generic/post/model/post_model.dart';
import 'package:superkauf/generic/store/model/store_model.dart';

part 'store_api.g.dart';

@RestApi()
abstract class StoreApi {
  factory StoreApi(Dio dio) = _StoreApi;

  @GET('/store')
  Future<List<StoreModel>> getStores();

  @GET('/store/posts/{id}')
  Future<List<FeedPostModel>> getPostsByStore({
    @Path() required int id,
  });
}
