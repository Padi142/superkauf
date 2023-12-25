// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] as int,
      comment: json['comment'] as String,
      user: json['user'] as int,
      post: json['post'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) => <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'user': instance.user,
      'post': instance.post,
      'created_at': instance.createdAt.toIso8601String(),
    };
