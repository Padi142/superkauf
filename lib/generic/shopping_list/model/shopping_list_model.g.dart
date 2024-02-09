// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingListModel _$ShoppingListModelFromJson(Map<String, dynamic> json) => ShoppingListModel(
      id: json['id'] as int,
      name: json['name'] as String,
      createdBy: json['created_by'] as int,
      logo: json['logo'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ShoppingListModelToJson(ShoppingListModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_by': instance.createdBy,
      'logo': instance.logo,
      'created_at': instance.createdAt.toIso8601String(),
    };
