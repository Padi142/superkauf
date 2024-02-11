import 'package:superkauf/generic/store/data/stores_repository.dart';
import 'package:superkauf/generic/store/model/get_store_result.dart';
import 'package:superkauf/library/use_case.dart';

class GetStoreUseCase extends UseCase<GetStoreResult, int> {
  StoresRepository repository;

  GetStoreUseCase({
    required this.repository,
  });

  @override
  Future<GetStoreResult> call(params) async {
    return await repository.getStore(params);
  }
}
