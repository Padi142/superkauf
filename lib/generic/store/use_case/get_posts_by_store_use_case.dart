import 'package:superkauf/generic/store/data/stores_repository.dart';
import 'package:superkauf/generic/store/model/get_posts_by_store_result.dart';
import 'package:superkauf/library/use_case.dart';

class GetPostsByStoreUseCase extends UseCase<GetPostsByStoreResult, int> {
  StoresRepository repository;

  GetPostsByStoreUseCase({
    required this.repository,
  });

  @override
  Future<GetPostsByStoreResult> call(params) async {
    return await repository.getPostsByStore(params);
  }
}
