import 'package:json_annotation/json_annotation.dart';

part 'update_user_body.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UpdateUserBody {
  final int id;
  final String? username;
  final String? profilePicture;

  const UpdateUserBody({
    required this.id,
    this.username,
    this.profilePicture,
  });

  factory UpdateUserBody.fromJson(Map<String, dynamic> json) => _$UpdateUserBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserBodyToJson(this);
}
