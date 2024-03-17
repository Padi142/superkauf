// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserBody _$UpdateUserBodyFromJson(Map<String, dynamic> json) => UpdateUserBody(
      id: json['id'] as int,
      username: json['username'] as String?,
      profilePicture: json['profile_picture'] as String?,
      instagram: json['instagram'] as String?,
    );

Map<String, dynamic> _$UpdateUserBodyToJson(UpdateUserBody instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profile_picture': instance.profilePicture,
      'instagram': instance.instagram,
    };
