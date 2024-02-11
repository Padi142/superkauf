import 'package:superkauf/generic/shopping_list/data/shopping_list_repository.dart';
import 'package:superkauf/generic/shopping_list/model/create_shopping_list_body.dart';
import 'package:superkauf/generic/shopping_list/model/get_single_shopping_list_info.dart';
import 'package:superkauf/library/use_case.dart';

class CreateShoppingListUseCase extends UseCase<GetSingleShoppingListInfoResult, CreateShoppingListBody> {
  ShoppingListRepository repository;

  CreateShoppingListUseCase({
    required this.repository,
  });

  @override
  Future<GetSingleShoppingListInfoResult> call(params) async {
    return await repository.createList(params);
  }
}
