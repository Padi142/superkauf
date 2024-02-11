// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_shopping_list_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateShoppingListBody _$CreateShoppingListBodyFromJson(Map<String, dynamic> json) => CreateShoppingListBody(
      createdBy: json['created_by'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CreateShoppingListBodyToJson(CreateShoppingListBody instance) => <String, dynamic>{
      'created_by': instance.createdBy,
      'name': instance.name,
    };
