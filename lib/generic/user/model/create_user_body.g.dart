// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserBody _$CreateUserBodyFromJson(Map<String, dynamic> json) => CreateUserBody(
      username: json['username'] as String,
      supabaseUid: json['supabase_uid'] as String,
    );

Map<String, dynamic> _$CreateUserBodyToJson(CreateUserBody instance) => <String, dynamic>{
      'username': instance.username,
      'supabase_uid': instance.supabaseUid,
    };
