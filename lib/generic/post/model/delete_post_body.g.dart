// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_post_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeletePostBody _$DeletePostBodyFromJson(Map<String, dynamic> json) => DeletePostBody(
      postId: json['post_id'] as String,
      author: json['author'] as String,
    );

Map<String, dynamic> _$DeletePostBodyToJson(DeletePostBody instance) => <String, dynamic>{
      'post_id': instance.postId,
      'author': instance.author,
    };
