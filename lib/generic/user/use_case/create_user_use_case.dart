import 'package:superkauf/generic/user/data/user_repository.dart';
import 'package:superkauf/generic/user/model/create_user_body.dart';
import 'package:superkauf/generic/user/model/get_user_result.dart';
import 'package:superkauf/library/use_case.dart';

class CreateUserUseCase extends UseCase<GetUserResult, CreateUserBody> {
  UserRepository repository;

  CreateUserUseCase({
    required this.repository,
  });

  @override
  Future<GetUserResult> call(params) async {
    return await repository.createUser(params);
  }
}
