import 'package:superkauf/generic/store/data/stores_repository.dart';
import 'package:superkauf/generic/store/model/get_stores_result.dart';
import 'package:superkauf/library/use_case.dart';

class GetStoresUseCase extends UnitUseCase<GetStoresResult> {
  StoresRepository repository;

  GetStoresUseCase({
    required this.repository,
  });

  @override
  Future<GetStoresResult> call() async {
    return await repository.getStores();
  }
}
