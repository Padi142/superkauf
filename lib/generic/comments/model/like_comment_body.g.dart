// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_comment_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeCommentBody _$LikeCommentBodyFromJson(Map<String, dynamic> json) => LikeCommentBody(
      comment: json['comment'] as int,
      user: json['user'] as int,
      type: json['type'] as String,
    );

Map<String, dynamic> _$LikeCommentBodyToJson(LikeCommentBody instance) => <String, dynamic>{
      'comment': instance.comment,
      'user': instance.user,
      'type': instance.type,
    };
