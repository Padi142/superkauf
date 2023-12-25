import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/comments/model/comment_model.dart';
import 'package:superkauf/generic/user/model/user_model.dart';

part 'post_comment_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PostCommentModel extends Equatable {
  final UserModel user;
  final CommentModel comment;

  const PostCommentModel({
    required this.user,
    required this.comment,
  });

  factory PostCommentModel.fromJson(Map<String, dynamic> json) => _$PostCommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostCommentModelToJson(this);

  @override
  List<Object?> get props => [
        user,
        comment,
      ];
}
