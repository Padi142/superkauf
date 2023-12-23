// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_post_image_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePostImageBody _$UpdatePostImageBodyFromJson(Map<String, dynamic> json) =>
    UpdatePostImageBody(
      postId: json['post_id'] as int,
      user: json['user'] as int,
      image: json['image'] as String,
    );

Map<String, dynamic> _$UpdatePostImageBodyToJson(
        UpdatePostImageBody instance) =>
    <String, dynamic>{
      'post_id': instance.postId,
      'user': instance.user,
      'image': instance.image,
    };
