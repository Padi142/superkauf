import 'package:superkauf/generic/post/model/get_posts_body.dart';
import 'package:superkauf/generic/store/data/stores_repository.dart';
import 'package:superkauf/generic/store/model/get_stores_result.dart';
import 'package:superkauf/library/use_case.dart';

class GetStoresUseCase extends UseCase<GetStoresResult, GetPostsBody> {
  StoresRepository repository;

  GetStoresUseCase({
    required this.repository,
  });

  @override
  Future<GetStoresResult> call(params) async {
    return await repository.getStores(params.country);
  }
}
