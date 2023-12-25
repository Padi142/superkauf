// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_comment_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCommentBody _$CreateCommentBodyFromJson(Map<String, dynamic> json) => CreateCommentBody(
      comment: json['comment'] as String,
      user: json['user'] as int,
      post: json['post'] as int,
    );

Map<String, dynamic> _$CreateCommentBodyToJson(CreateCommentBody instance) => <String, dynamic>{
      'comment': instance.comment,
      'user': instance.user,
      'post': instance.post,
    };
