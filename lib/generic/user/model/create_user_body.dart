import 'package:json_annotation/json_annotation.dart';

part 'create_user_body.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CreateUserBody {
  final String username;
  final String supabaseUid;

  const CreateUserBody({
    required this.username,
    required this.supabaseUid,
  });

  factory CreateUserBody.fromJson(Map<String, dynamic> json) => _$CreateUserBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserBodyToJson(this);
}
