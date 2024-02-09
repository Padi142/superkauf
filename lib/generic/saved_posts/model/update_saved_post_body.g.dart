// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_saved_post_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateSavedPostBody _$UpdateSavedPostBodyFromJson(Map<String, dynamic> json) => UpdateSavedPostBody(
      savedPostId: json['saved_post_id'] as int,
      isCompleted: json['is_completed'] as bool,
    );

Map<String, dynamic> _$UpdateSavedPostBodyToJson(UpdateSavedPostBody instance) => <String, dynamic>{
      'saved_post_id': instance.savedPostId,
      'is_completed': instance.isCompleted,
    };
