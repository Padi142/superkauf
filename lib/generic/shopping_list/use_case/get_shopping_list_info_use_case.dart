import 'package:superkauf/generic/shopping_list/data/shopping_list_repository.dart';
import 'package:superkauf/generic/shopping_list/model/get_shopping_list_result.dart';
import 'package:superkauf/library/use_case.dart';

class GetShoppingListInfoUseCase extends UseCase<GetShoppingListInfoResult, int> {
  ShoppingListRepository repository;

  GetShoppingListInfoUseCase({
    required this.repository,
  });

  @override
  Future<GetShoppingListInfoResult> call(params) async {
    return await repository.getListInfo(params);
  }
}
