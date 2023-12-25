import 'package:json_annotation/json_annotation.dart';

part 'update_post_body.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UpdatePostBody {
  final int postId;
  final int user;
  final String content;

  const UpdatePostBody({
    required this.postId,
    required this.user,
    required this.content,
  });

  factory UpdatePostBody.fromJson(Map<String, dynamic> json) => _$UpdatePostBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePostBodyToJson(this);
}
