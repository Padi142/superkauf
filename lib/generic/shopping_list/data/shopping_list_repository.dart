import 'package:dio/dio.dart';
import 'package:superkauf/generic/api/shopping_list_api.dart';
import 'package:superkauf/generic/shopping_list/model/add_post_to_list_result.dart';
import 'package:superkauf/generic/shopping_list/model/add_saved_post_to_list_body.dart';
import 'package:superkauf/generic/shopping_list/model/create_shopping_list_body.dart';
import 'package:superkauf/generic/shopping_list/model/generic_list_response.dart';
import 'package:superkauf/generic/shopping_list/model/get_shopping_list_result.dart';
import 'package:superkauf/generic/shopping_list/model/get_shopping_lists_for_user_result.dart';
import 'package:superkauf/generic/shopping_list/model/get_single_shopping_list_info.dart';
import 'package:superkauf/generic/shopping_list/model/join_shopping_list_body.dart';
import 'package:superkauf/generic/shopping_list/model/join_user_list_result.dart';

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

  Future<AddSavedPostToLostResult> addSavedPostToList(AddSavedPostToListBody body) async {
    return shoppingListApi.addSavedPostToList(body: body.toJson()).then((result) {
      return result ? const AddSavedPostToLostResult.success() : const AddSavedPostToLostResult.failure('error saved post');
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return AddSavedPostToLostResult.failure(error.message ?? 'error deleting comment');
      }
      return const AddSavedPostToLostResult.failure('error');
    });
  }

  Future<AddSavedPostToLostResult> removeSavedPostFromList(RemoveSavedPostFromListBody body) async {
    return shoppingListApi.removeSavedPostFromList(listId: body.listId, savedPostId: body.savedPostId!, userId: body.userId).then((result) {
      return result ? const AddSavedPostToLostResult.success() : const AddSavedPostToLostResult.failure('error deleting saved post');
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return AddSavedPostToLostResult.failure(error.message ?? 'error deleting comment');
      }
      return const AddSavedPostToLostResult.failure('error');
    });
  }

  Future<AddSavedPostToLostResult> removePostFromList(AddSavedPostToListBody body) async {
    return shoppingListApi.removePostFromList(body: body.toJson(), listId: body.listId).then((result) {
      return result ? const AddSavedPostToLostResult.success() : const AddSavedPostToLostResult.failure('error deleting saved post');
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return AddSavedPostToLostResult.failure(error.message ?? 'error deleting comment');
      }
      return const AddSavedPostToLostResult.failure('error');
    });
  }

  Future<GetSingleShoppingListInfoResult> createList(CreateShoppingListBody body) async {
    return shoppingListApi.createShoppingList(body: body.toJson()).then((lists) {
      return GetSingleShoppingListInfoResult.success(lists);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetSingleShoppingListInfoResult.failure(error.message ?? 'error creating list');
      }
      return const GetSingleShoppingListInfoResult.failure('error');
    });
  }

  Future<JoinUserToListResult> joinShoppingList(JoinShoppingListBody body) async {
    return shoppingListApi.joinShoppingList(body: body.toJson()).then((lists) {
      return JoinUserToListResult.success(lists);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return JoinUserToListResult.failure(error.message ?? 'error joining list');
      }
      return const JoinUserToListResult.failure('error');
    });
  }

  Future<GenericListResponse> leaveShoppingList(DeleteShoppingListBody body) async {
    return shoppingListApi.leaveShoppingList(body: body.toJson()).then((lists) {
      return const GenericListResponse.success();
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GenericListResponse.failure(error.message ?? 'error joining list');
      }
      return const GenericListResponse.failure('error');
    });
  }

  Future<GenericListResponse> deleteList(DeleteShoppingListBody body) async {
    return shoppingListApi.deleteList(userId: body.userId, listId: body.listId).then((lists) {
      return const GenericListResponse.success();
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GenericListResponse.failure(error.message ?? 'error joining list');
      }
      return const GenericListResponse.failure('error');
    });
  }
}
