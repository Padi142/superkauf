import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'like_comment_body.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class LikeCommentBody extends Equatable {
  final int comment;
  final int user;
  final String type;

  const LikeCommentBody({
    required this.comment,
    required this.user,
    required this.type,
  });

  factory LikeCommentBody.fromJson(Map<String, dynamic> json) => _$LikeCommentBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LikeCommentBodyToJson(this);

  @override
  List<Object?> get props => [
        comment,
        user,
        type,
      ];
}
