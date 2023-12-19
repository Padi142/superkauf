import 'package:json_annotation/json_annotation.dart';

part 'delete_post_body.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class DeletePostBody {
  final String postId;
  final String author;

  const DeletePostBody({
    required this.postId,
    required this.author,
  });

  factory DeletePostBody.fromJson(Map<String, dynamic> json) => _$DeletePostBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DeletePostBodyToJson(this);
}
