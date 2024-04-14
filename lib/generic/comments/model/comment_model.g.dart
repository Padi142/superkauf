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
      parentId: json['parent_id'] as int?,
      reactionId: json['reaction_id'] as int?,
      likes: json['likes'] as int,
      reaction: json['reaction'] == null ? null : ReactionModel.fromJson(json['reaction'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) => <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'user': instance.user,
      'post': instance.post,
      'parent_id': instance.parentId,
      'reaction_id': instance.reactionId,
      'reaction': instance.reaction?.toJson(),
      'likes': instance.likes,
      'created_at': instance.createdAt.toIso8601String(),
    };
