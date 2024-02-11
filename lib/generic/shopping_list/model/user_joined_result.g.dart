// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_joined_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserJoinedResult _$UserJoinedResultFromJson(Map<String, dynamic> json) => UserJoinedResult(
      userId: json['user_id'] as int,
      shoppingListId: json['shopping_list_id'] as int,
      role: json['role'] as String,
    );

Map<String, dynamic> _$UserJoinedResultToJson(UserJoinedResult instance) => <String, dynamic>{
      'user_id': instance.userId,
      'shopping_list_id': instance.shoppingListId,
      'role': instance.role,
    };
