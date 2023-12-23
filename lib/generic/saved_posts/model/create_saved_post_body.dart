import 'package:json_annotation/json_annotation.dart';

part 'create_saved_post_body.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CreateSavedPostBody {
  final int user;
  final int post;

  const CreateSavedPostBody({
    required this.user,
    required this.post,
  });

  factory CreateSavedPostBody.fromJson(Map<String, dynamic> json) => _$CreateSavedPostBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSavedPostBodyToJson(this);
}
