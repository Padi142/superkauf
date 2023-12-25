// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_saved_post_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteSavedPostBody _$DeleteSavedPostBodyFromJson(Map<String, dynamic> json) => DeleteSavedPostBody(
      user: json['user'] as int,
      savedPostId: json['saved_post_id'] as int,
    );

Map<String, dynamic> _$DeleteSavedPostBodyToJson(DeleteSavedPostBody instance) => <String, dynamic>{
      'user': instance.user,
      'saved_post_id': instance.savedPostId,
    };
