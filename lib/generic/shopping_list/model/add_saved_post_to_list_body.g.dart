// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_saved_post_to_list_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddSavedPostToListBody _$AddSavedPostToListBodyFromJson(Map<String, dynamic> json) => AddSavedPostToListBody(
      savedPostId: json['saved_post_id'] as int?,
      postId: json['post_id'] as int?,
      listId: json['list_id'] as int,
      userId: json['user_id'] as int,
    );

Map<String, dynamic> _$AddSavedPostToListBodyToJson(AddSavedPostToListBody instance) => <String, dynamic>{
      'saved_post_id': instance.savedPostId,
      'list_id': instance.listId,
      'user_id': instance.userId,
      'post_id': instance.postId,
    };

RemoveSavedPostFromListBody _$RemoveSavedPostFromListBodyFromJson(Map<String, dynamic> json) => RemoveSavedPostFromListBody(
      savedPostId: json['saved_post_id'] as int?,
      postId: json['post_id'] as int?,
      listId: json['list_id'] as int,
      userId: json['user_id'] as int,
    );

Map<String, dynamic> _$RemoveSavedPostFromListBodyToJson(RemoveSavedPostFromListBody instance) => <String, dynamic>{
      'saved_post_id': instance.savedPostId,
      'list_id': instance.listId,
      'user_id': instance.userId,
      'post_id': instance.postId,
    };
