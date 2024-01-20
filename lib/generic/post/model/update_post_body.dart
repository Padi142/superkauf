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

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UpdatePostValidUntilBody {
  final int postId;
  final int user;
  final DateTime validUntil;

  const UpdatePostValidUntilBody({
    required this.postId,
    required this.user,
    required this.validUntil,
  });

  factory UpdatePostValidUntilBody.fromJson(Map<String, dynamic> json) => _$UpdatePostValidUntilBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePostValidUntilBodyToJson(this);
}
