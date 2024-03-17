// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePostModel _$CreatePostModelFromJson(Map<String, dynamic> json) => CreatePostModel(
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      author: json['author'] as String,
      storeName: json['store_name'] as String,
      store: json['store'] as int,
      country: json['country'] as String,
      validUntil: json['valid_until'] == null ? null : DateTime.parse(json['valid_until'] as String),
      requiresStoreCard: json['requires_store_card'] as bool,
    );

Map<String, dynamic> _$CreatePostModelToJson(CreatePostModel instance) => <String, dynamic>{
      'description': instance.description,
      'price': instance.price,
      'author': instance.author,
      'store_name': instance.storeName,
      'country': instance.country,
      'store': instance.store,
      'valid_until': instance.validUntil?.toIso8601String(),
      'requires_store_card': instance.requiresStoreCard,
    };
