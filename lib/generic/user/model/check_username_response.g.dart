// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_username_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUsernameResponse _$CheckUsernameResponseFromJson(Map<String, dynamic> json) => CheckUsernameResponse(
      user: json['user'] == null ? null : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$CheckUsernameResponseToJson(CheckUsernameResponse instance) => <String, dynamic>{
      'user': instance.user?.toJson(),
      'error': instance.error,
    };
