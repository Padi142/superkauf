// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: json['id'] as int,
      description: json['description'] as String,
      author: json['author'] as int,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      storeName: json['store_name'] as String,
      store: json['store'] as int,
      likes: json['likes'] as int,
      requiresStoreCard: json['requires_store_card'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'author': instance.author,
      'price': instance.price,
      'image': instance.image,
      'store_name': instance.storeName,
      'store': instance.store,
      'likes': instance.likes,
      'requires_store_card': instance.requiresStoreCard,
      'created_at': instance.createdAt.toIso8601String(),
    };
