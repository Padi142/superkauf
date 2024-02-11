// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_shopping_list_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinShoppingListBody _$JoinShoppingListBodyFromJson(Map<String, dynamic> json) => JoinShoppingListBody(
      code: json['code'] as String,
      userId: json['user_id'] as int,
    );

Map<String, dynamic> _$JoinShoppingListBodyToJson(JoinShoppingListBody instance) => <String, dynamic>{
      'code': instance.code,
      'user_id': instance.userId,
    };

DeleteShoppingListBody _$DeleteShoppingListBodyFromJson(Map<String, dynamic> json) => DeleteShoppingListBody(
      listId: json['list_id'] as int,
      userId: json['user_id'] as int,
    );

Map<String, dynamic> _$DeleteShoppingListBodyToJson(DeleteShoppingListBody instance) => <String, dynamic>{
      'list_id': instance.listId,
      'user_id': instance.userId,
    };
