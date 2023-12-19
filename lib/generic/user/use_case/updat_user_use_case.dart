import 'package:superkauf/generic/post/use_case/update_user_body.dart';
import 'package:superkauf/generic/user/data/user_repository.dart';
import 'package:superkauf/generic/user/model/get_user_result.dart';
import 'package:superkauf/library/use_case.dart';

class UpdateUserUseCase extends UseCase<GetUserResult, UpdateUserBody> {
  UserRepository repository;

  UpdateUserUseCase({
    required this.repository,
  });

  @override
  Future<GetUserResult> call(params) async {
    return await repository.updateUser(params.id, params);
  }
}
