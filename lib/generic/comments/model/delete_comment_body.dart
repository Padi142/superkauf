import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_comment_body.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class DeleteCommentBody extends Equatable {
  final int commentId;
  final int user;

  const DeleteCommentBody({
    required this.commentId,
    required this.user,
  });

  factory DeleteCommentBody.fromJson(Map<String, dynamic> json) =>
      _$DeleteCommentBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteCommentBodyToJson(this);

  @override
  List<Object?> get props => [
        commentId,
        user,
      ];
}
