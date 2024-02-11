import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:superkauf/generic/shopping_list/model/get_shopping_list_response.dart';
import 'package:superkauf/generic/shopping_list/model/shopping_list_model.dart';
import 'package:superkauf/generic/shopping_list/model/user_joined_result.dart';

part 'shopping_list_api.g.dart';

@RestApi()
abstract class ShoppingListApi {
  factory ShoppingListApi(Dio dio) = _ShoppingListApi;

  @GET('/shopping_lists/users/{userId}')
  Future<List<ShoppingListModel>> getUserLists({
    @Path('userId') required int userId,
  });

  @GET('/shopping_lists/{listId}')
  Future<GetShoppingListResponse> getList({
    @Path('listId') required int listId,
  });

  @POST('/shopping_lists/posts')
  Future<bool> addSavedPostToList({
    @Body() required Map<String, dynamic> body,
  });

  @POST('/shopping_lists/posts/{listId}/{savedPostId}?userId={userId}')
  Future<bool> removeSavedPostFromList({
    @Path('listId') required int listId,
    @Path('savedPostId') required int savedPostId,
    @Path('userId') required int userId,
  });

  @POST('/shopping_lists')
  Future<ShoppingListModel> createShoppingList({
    @Body() required Map<String, dynamic> body,
  });

  @POST('/shopping_lists/users')
  Future<UserJoinedResult> joinShoppingList({
    @Body() required Map<String, dynamic> body,
  });

  @DELETE('/shopping_lists/users')
  Future<dynamic> leaveShoppingList({
    @Body() required Map<String, dynamic> body,
  });

  @DELETE('/shopping_lists/{listId}?userId={userId}')
  Future<ShoppingListModel> deleteList({
    @Path('listId') required int listId,
    @Path('userId') required int userId,
  });
}
