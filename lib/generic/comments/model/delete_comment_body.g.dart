// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_comment_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteCommentBody _$DeleteCommentBodyFromJson(Map<String, dynamic> json) =>
    DeleteCommentBody(
      commentId: json['comment_id'] as int,
      user: json['user'] as int,
    );

Map<String, dynamic> _$DeleteCommentBodyToJson(DeleteCommentBody instance) =>
    <String, dynamic>{
      'comment_id': instance.commentId,
      'user': instance.user,
    };
