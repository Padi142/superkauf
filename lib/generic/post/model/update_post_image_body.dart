import 'package:json_annotation/json_annotation.dart';

part 'update_post_image_body.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UpdatePostImageBody {
  final int postId;
  final int user;
  final String image;

  const UpdatePostImageBody({
    required this.postId,
    required this.user,
    required this.image,
  });

  factory UpdatePostImageBody.fromJson(Map<String, dynamic> json) =>
      _$UpdatePostImageBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePostImageBodyToJson(this);
}
