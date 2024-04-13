import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_comment_body.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CreateCommentBody extends Equatable {
  final String comment;
  final int user;
  final int post;
  final int? parentId;
  final int? reactionId;

  const CreateCommentBody({
    required this.comment,
    required this.user,
    required this.post,
    required this.parentId,
    required this.reactionId,
  });

  factory CreateCommentBody.fromJson(Map<String, dynamic> json) => _$CreateCommentBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCommentBodyToJson(this);

  @override
  List<Object?> get props => [
        comment,
        user,
        post,
      ];
}
