import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';
import 'package:superkauf/generic/store/model/store_model.dart';

part 'store_api.g.dart';

@RestApi()
abstract class StoreApi {
  factory StoreApi(Dio dio) = _StoreApi;

  @GET('/store?country={country}')
  Future<List<StoreModel>> getStores({
    @Path() required String country,
  });

  @GET('/store/posts/{id}?per_page={perPage}&offset={offset}&userId={userId}?country={country}')
  Future<GetPaginatedPostsResponseModel> getPostsByStore({
    @Path() required int id,
    @Path() required int perPage,
    @Path() required int offset,
    @Path() required int? userId,
    @Path() required String country,
  });

  @GET('/store/{id}')
  Future<StoreModel> getStore({
    @Path() required int id,
  });
}
