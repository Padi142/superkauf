import 'package:json_annotation/json_annotation.dart';

part 'delete_saved_post_body.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class DeleteSavedPostBody {
  final int user;
  final int savedPostId;

  const DeleteSavedPostBody({
    required this.user,
    required this.savedPostId,
  });

  factory DeleteSavedPostBody.fromJson(Map<String, dynamic> json) => _$DeleteSavedPostBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteSavedPostBodyToJson(this);
}
