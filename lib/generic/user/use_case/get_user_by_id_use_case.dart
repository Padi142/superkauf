import 'package:superkauf/generic/user/data/user_repository.dart';
import 'package:superkauf/generic/user/model/get_user_result.dart';
import 'package:superkauf/library/use_case.dart';

class GetUserByIdUseCase extends UseCase<GetUserResult, int> {
  UserRepository repository;

  GetUserByIdUseCase({
    required this.repository,
  });

  @override
  Future<GetUserResult> call(params) async {
    return await repository.getUserById(params);
  }
}
