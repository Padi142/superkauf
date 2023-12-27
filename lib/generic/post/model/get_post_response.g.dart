// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPostsResponseModel _$GetPostsResponseModelFromJson(Map<String, dynamic> json) => GetPostsResponseModel(
      posts: (json['posts'] as List<dynamic>).map((e) => FeedPostModel.fromJson(e as Map<String, dynamic>)).toList(),
      pagination: PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetPostsResponseModelToJson(GetPostsResponseModel instance) => <String, dynamic>{
      'posts': instance.posts.map((e) => e.toJson()).toList(),
      'pagination': instance.pagination.toJson(),
    };

FeedPostModel _$FeedPostModelFromJson(Map<String, dynamic> json) => FeedPostModel(
      post: PostModel.fromJson(json['post'] as Map<String, dynamic>),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedPostModelToJson(FeedPostModel instance) => <String, dynamic>{
      'post': instance.post.toJson(),
      'user': instance.user.toJson(),
    };
