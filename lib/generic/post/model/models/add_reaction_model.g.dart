// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_reaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddReactionModel _$AddReactionModelFromJson(Map<String, dynamic> json) => AddReactionModel(
      user: json['user'] as int,
      post: json['post'] as int,
      type: json['type'] as String,
    );

Map<String, dynamic> _$AddReactionModelToJson(AddReactionModel instance) => <String, dynamic>{
      'user': instance.user,
      'post': instance.post,
      'type': instance.type,
    };

RemoveReactionModel _$RemoveReactionModelFromJson(Map<String, dynamic> json) => RemoveReactionModel(
      user: json['user'] as int,
      post: json['post'] as int,
      type: json['type'] as String,
    );

Map<String, dynamic> _$RemoveReactionModelToJson(RemoveReactionModel instance) => <String, dynamic>{
      'user': instance.user,
      'post': instance.post,
      'type': instance.type,
    };
