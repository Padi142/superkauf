import 'package:superkauf/generic/shopping_list/data/shopping_list_repository.dart';
import 'package:superkauf/generic/shopping_list/model/join_shopping_list_body.dart';
import 'package:superkauf/generic/shopping_list/model/join_user_list_result.dart';
import 'package:superkauf/library/use_case.dart';

class JoinUserToShoppingListUseCase extends UseCase<JoinUserToListResult, JoinShoppingListBody> {
  ShoppingListRepository repository;

  JoinUserToShoppingListUseCase({
    required this.repository,
  });

  @override
  Future<JoinUserToListResult> call(params) async {
    return await repository.joinShoppingList(params);
  }
}
