// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_personal_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPaginatedPostsResponseModel _$GetPaginatedPostsResponseModelFromJson(Map<String, dynamic> json) => GetPaginatedPostsResponseModel(
      posts: (json['posts'] as List<dynamic>).map((e) => FullContextPostModel.fromJson(e as Map<String, dynamic>)).toList(),
      pagination: PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetPaginatedPostsResponseModelToJson(GetPaginatedPostsResponseModel instance) => <String, dynamic>{
      'posts': instance.posts.map((e) => e.toJson()).toList(),
      'pagination': instance.pagination.toJson(),
    };

FullContextPostModel _$FullContextPostModelFromJson(Map<String, dynamic> json) => FullContextPostModel(
      post: PostModel.fromJson(json['post'] as Map<String, dynamic>),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      reaction: json['reaction'] == null ? null : ReactionModel.fromJson(json['reaction'] as Map<String, dynamic>),
      saved: json['saved'] == null ? null : SavedPostModel.fromJson(json['saved'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FullContextPostModelToJson(FullContextPostModel instance) => <String, dynamic>{
      'post': instance.post.toJson(),
      'user': instance.user.toJson(),
      'reaction': instance.reaction?.toJson(),
      'saved': instance.saved?.toJson(),
    };

GetPersonalFeedParams _$GetPersonalFeedParamsFromJson(Map<String, dynamic> json) => GetPersonalFeedParams(
      body: GetPostsBody.fromJson(json['body'] as Map<String, dynamic>),
      userId: json['user_id'] as int,
    );

Map<String, dynamic> _$GetPersonalFeedParamsToJson(GetPersonalFeedParams instance) => <String, dynamic>{
      'body': instance.body.toJson(),
      'user_id': instance.userId,
    };

GetTopPostsParams _$GetTopPostsParamsFromJson(Map<String, dynamic> json) => GetTopPostsParams(
      body: GetPostsBody.fromJson(json['body'] as Map<String, dynamic>),
      userId: json['user_id'] as int,
      store: json['store'] as int?,
      timeRange: json['time_range'] as String,
      sortBy: json['sort_by'] as String,
    );

Map<String, dynamic> _$GetTopPostsParamsToJson(GetTopPostsParams instance) => <String, dynamic>{
      'body': instance.body.toJson(),
      'user_id': instance.userId,
      'store': instance.store,
      'time_range': instance.timeRange,
      'sort_by': instance.sortBy,
    };
