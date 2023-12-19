import 'package:superkauf/generic/user/data/user_repository.dart';
import 'package:superkauf/generic/user/model/get_user_result.dart';
import 'package:superkauf/library/use_case.dart';

class GetUserByUidUseCase extends UseCase<GetUserResult, String> {
  UserRepository repository;

  GetUserByUidUseCase({
    required this.repository,
  });

  @override
  Future<GetUserResult> call(params) async {
    return await repository.getUserByUid(params);
  }
}
