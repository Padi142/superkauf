import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/shopping_list/model/user_joined_result.dart';

part 'join_user_list_result.freezed.dart';

@freezed
class JoinUserToListResult with _$JoinUserToListResult {
  const factory JoinUserToListResult.success(UserJoinedResult joined) = Success;

  const factory JoinUserToListResult.failure(String message) = Failure;
}
