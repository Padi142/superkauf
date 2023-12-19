// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      isAdmin: json['is_admin'] as bool,
      lastLoggedIn: DateTime.parse(json['last_logged_in'] as String),
      profilePicture: json['profile_picture'] as String,
      karma: json['karma'] as int,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'created_at': instance.createdAt.toIso8601String(),
      'is_admin': instance.isAdmin,
      'last_logged_in': instance.lastLoggedIn.toIso8601String(),
      'profile_picture': instance.profilePicture,
      'karma': instance.karma,
    };
