import 'package:dio/dio.dart';
import 'package:superkauf/generic/api/shopping_list_api.dart';
import 'package:superkauf/generic/shopping_list/model/get_shopping_list_result.dart';
import 'package:superkauf/generic/shopping_list/model/get_shopping_lists_for_user_result.dart';

class ShoppingListRepository {
  final ShoppingListApi shoppingListApi;

  ShoppingListRepository({
    required this.shoppingListApi,
  });
  Future<GetShoppingListsForUserResult> getListsForUser(int userId) async {
    return shoppingListApi.getUserLists(userId: userId).then((lists) {
      return GetShoppingListsForUserResult.success(lists);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetShoppingListsForUserResult.failure(error.message ?? 'error deleting comment');
      }
      return const GetShoppingListsForUserResult.failure('error');
    });
  }

  Future<GetShoppingListInfoResult> getListInfo(int listId) async {
    return shoppingListApi.getList(listId: listId).then((lists) {
      return GetShoppingListInfoResult.success(lists);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetShoppingListInfoResult.failure(error.message ?? 'error deleting comment');
      }
      return const GetShoppingListInfoResult.failure('error');
    });
  }
}
