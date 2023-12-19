import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/user/model/user_model.dart';

part 'get_user_result.freezed.dart';

@freezed
class GetUserResult with _$GetUserResult {
  const factory GetUserResult.success(UserModel user) = Success;

  const factory GetUserResult.failure(String message) = Failure;
}
