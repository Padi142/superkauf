import 'package:superkauf/generic/shopping_list/data/shopping_list_repository.dart';
import 'package:superkauf/generic/shopping_list/model/add_post_to_list_result.dart';
import 'package:superkauf/generic/shopping_list/model/add_saved_post_to_list_body.dart';
import 'package:superkauf/library/use_case.dart';

class RemoveSavedPostFromListUseCase extends UseCase<AddSavedPostToLostResult, RemoveSavedPostFromListBody> {
  ShoppingListRepository repository;

  RemoveSavedPostFromListUseCase({
    required this.repository,
  });

  @override
  Future<AddSavedPostToLostResult> call(params) async {
    return await repository.removeSavedPostFromList(params);
  }
}
