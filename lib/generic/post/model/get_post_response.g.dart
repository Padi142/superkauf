// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedPostModel _$FeedPostModelFromJson(Map<String, dynamic> json) =>
    FeedPostModel(
      post: PostModel.fromJson(json['posts'] as Map<String, dynamic>),
      user: UserModel.fromJson(json['users'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedPostModelToJson(FeedPostModel instance) =>
    <String, dynamic>{
      'posts': instance.post.toJson(),
      'users': instance.user.toJson(),
    };
