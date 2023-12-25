// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_post_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePostBody _$UpdatePostBodyFromJson(Map<String, dynamic> json) => UpdatePostBody(
      postId: json['post_id'] as int,
      user: json['user'] as int,
      content: json['content'] as String,
    );

Map<String, dynamic> _$UpdatePostBodyToJson(UpdatePostBody instance) => <String, dynamic>{
      'post_id': instance.postId,
      'user': instance.user,
      'content': instance.content,
    };
