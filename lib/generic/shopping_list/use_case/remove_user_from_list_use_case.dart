import 'package:superkauf/generic/shopping_list/data/shopping_list_repository.dart';
import 'package:superkauf/generic/shopping_list/model/generic_list_response.dart';
import 'package:superkauf/generic/shopping_list/model/join_shopping_list_body.dart';
import 'package:superkauf/library/use_case.dart';

class RemoveUserFromShoppingListUseCase extends UseCase<GenericListResponse, DeleteShoppingListBody> {
  ShoppingListRepository repository;

  RemoveUserFromShoppingListUseCase({
    required this.repository,
  });

  @override
  Future<GenericListResponse> call(params) async {
    return await repository.leaveShoppingList(params);
  }
}
