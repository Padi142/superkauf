// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPostModel _$SearchPostModelFromJson(Map<String, dynamic> json) => SearchPostModel(
      id: json['id'] as int,
      description: json['description'] as String,
      storeName: json['store_name'] as String,
      image: json['image'] as String,
      price: (json['price'] as num?)?.toDouble(),
      author: json['author'] as int?,
    );

Map<String, dynamic> _$SearchPostModelToJson(SearchPostModel instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'store_name': instance.storeName,
      'image': instance.image,
      'price': instance.price,
      'author': instance.author,
    };
