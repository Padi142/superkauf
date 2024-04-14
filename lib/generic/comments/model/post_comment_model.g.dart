// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCommentModel _$PostCommentModelFromJson(Map<String, dynamic> json) =>
    PostCommentModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      comment: CommentModel.fromJson(json['comment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostCommentModelToJson(PostCommentModel instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'comment': instance.comment.toJson(),
    };
