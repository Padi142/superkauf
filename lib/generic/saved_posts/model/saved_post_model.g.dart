// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedPostModel _$SavedPostModelFromJson(Map<String, dynamic> json) => SavedPostModel(
      id: json['id'] as int,
      post: json['post'] as int,
      user: json['user'] as int,
      isCompleted: json['is_completed'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$SavedPostModelToJson(SavedPostModel instance) => <String, dynamic>{
      'id': instance.id,
      'post': instance.post,
      'user': instance.user,
      'is_completed': instance.isCompleted,
      'created_at': instance.createdAt.toIso8601String(),
    };
