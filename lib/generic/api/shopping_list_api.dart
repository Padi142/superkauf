import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:superkauf/generic/shopping_list/model/get_shopping_list_response.dart';
import 'package:superkauf/generic/shopping_list/model/shopping_list_model.dart';

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
}
