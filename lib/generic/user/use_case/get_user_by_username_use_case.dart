import 'package:superkauf/generic/user/data/user_repository.dart';
import 'package:superkauf/generic/user/model/get_user_result.dart';
import 'package:superkauf/library/use_case.dart';

class GetUserByUsernameUseCase extends UseCase<GetUserResult, String> {
  UserRepository repository;

  GetUserByUsernameUseCase({
    required this.repository,
  });

  @override
  Future<GetUserResult> call(params) async {
    return await repository.getUserByUsername(params);
  }
}
