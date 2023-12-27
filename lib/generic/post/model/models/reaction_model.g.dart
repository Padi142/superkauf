// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReactionModel _$ReactionModelFromJson(Map<String, dynamic> json) => ReactionModel(
      id: json['id'] as int,
      user: json['user'] as int,
      post: json['post'] as int,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ReactionModelToJson(ReactionModel instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'post': instance.post,
      'type': instance.type,
      'created_at': instance.createdAt.toIso8601String(),
    };
