import 'package:dio/dio.dart';
import 'package:superkauf/generic/api/store_api.dart';
import 'package:superkauf/generic/store/model/get_post_by_store_params.dart';
import 'package:superkauf/generic/store/model/get_posts_by_store_result.dart';
import 'package:superkauf/generic/store/model/get_store_result.dart';
import 'package:superkauf/generic/store/model/get_stores_result.dart';

class StoresRepository {
  final StoreApi storeApi;

  StoresRepository({
    required this.storeApi,
  });

  Future<GetStoresResult> getStores(String country) async {
    return storeApi.getStores(country: country).then((stores) {
      return GetStoresResult.success(stores);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetStoresResult.failure(error.message ?? 'error getting stores');
      }
      return const GetStoresResult.failure('error');
    });
  }

  Future<GetPostsByStoreResult> getPostsByStore(GetStorePostsParams params) async {
    return storeApi
        .getPostsByStore(
      id: params.storeId,
      userId: params.userId,
      offset: params.pagination.offset,
      perPage: params.pagination.perPage,
      country: params.country,
    )
        .then((stores) {
      return GetPostsByStoreResult.success(stores);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetPostsByStoreResult.failure(error.message ?? 'error getting posts by stores');
      }
      return const GetPostsByStoreResult.failure('error');
    });
  }

  Future<GetStoreResult> getStore(int storeId) async {
    return storeApi.getStore(id: storeId).then((stores) {
      return GetStoreResult.success(stores);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetStoreResult.failure(error.message ?? 'error getting store');
      }
      return const GetStoreResult.failure('error');
    });
  }
}
