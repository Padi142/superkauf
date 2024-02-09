import 'package:superkauf/generic/shopping_list/data/shopping_list_repository.dart';
import 'package:superkauf/generic/shopping_list/model/get_shopping_lists_for_user_result.dart';
import 'package:superkauf/library/use_case.dart';

class GetShoppingListsForUserUseCase extends UseCase<GetShoppingListsForUserResult, int> {
  ShoppingListRepository repository;

  GetShoppingListsForUserUseCase({
    required this.repository,
  });

  @override
  Future<GetShoppingListsForUserResult> call(params) async {
    return await repository.getListsForUser(params);
  }
}
