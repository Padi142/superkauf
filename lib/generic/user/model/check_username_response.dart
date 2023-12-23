import 'package:json_annotation/json_annotation.dart';
import 'package:superkauf/generic/user/model/user_model.dart';

part 'check_username_response.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CheckUsernameResponse {
  final UserModel? user;
  final String? error;

  const CheckUsernameResponse({
    required this.user,
    required this.error,
  });

  factory CheckUsernameResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckUsernameResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckUsernameResponseToJson(this);
}
