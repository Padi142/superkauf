import 'package:json_annotation/json_annotation.dart';

part 'update_saved_post_body.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UpdateSavedPostBody {
  final int savedPostId;
  final bool isCompleted;

  const UpdateSavedPostBody({
    required this.savedPostId,
    required this.isCompleted,
  });

  factory UpdateSavedPostBody.fromJson(Map<String, dynamic> json) => _$UpdateSavedPostBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateSavedPostBodyToJson(this);
}
