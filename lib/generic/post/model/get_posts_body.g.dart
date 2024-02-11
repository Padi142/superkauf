// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_posts_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPostsBody _$GetPostsBodyFromJson(Map<String, dynamic> json) => GetPostsBody(
      pagination: GetPostsPaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
      country: json['country'] as String,
    );

Map<String, dynamic> _$GetPostsBodyToJson(GetPostsBody instance) => <String, dynamic>{
      'pagination': instance.pagination.toJson(),
      'country': instance.country,
    };
