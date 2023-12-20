import 'package:dio/dio.dart';
import 'package:superkauf/generic/api/store_api.dart';
import 'package:superkauf/generic/store/model/get_posts_by_store_result.dart';
import 'package:superkauf/generic/store/model/get_stores_result.dart';

class StoresRepository {
  final StoreApi storeApi;

  StoresRepository({
    required this.storeApi,
  });

  Future<GetStoresResult> getStores() async {
    return storeApi.getStores().then((stores) {
      return GetStoresResult.success(stores);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetStoresResult.failure(error.message ?? 'error getting stores');
      }
      return const GetStoresResult.failure('error');
    });
  }

  Future<GetPostsByStoreResult> getPostsByStore(int storeID) async {
    return storeApi.getPostsByStore(id: storeID).then((stores) {
      return GetPostsByStoreResult.success(stores);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetPostsByStoreResult.failure(error.message ?? 'error getting posts by stores');
      }
      return const GetPostsByStoreResult.failure('error');
    });
  }
}
