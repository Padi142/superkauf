// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_personal_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPersonalFeedResponseModel _$GetPersonalFeedResponseModelFromJson(Map<String, dynamic> json) => GetPersonalFeedResponseModel(
      posts: (json['posts'] as List<dynamic>).map((e) => FeedPersonalPostModel.fromJson(e as Map<String, dynamic>)).toList(),
      pagination: PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetPersonalFeedResponseModelToJson(GetPersonalFeedResponseModel instance) => <String, dynamic>{
      'posts': instance.posts.map((e) => e.toJson()).toList(),
      'pagination': instance.pagination.toJson(),
    };

FeedPersonalPostModel _$FeedPersonalPostModelFromJson(Map<String, dynamic> json) => FeedPersonalPostModel(
      post: PostModel.fromJson(json['post'] as Map<String, dynamic>),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      reaction: json['reaction'] == null ? null : ReactionModel.fromJson(json['reaction'] as Map<String, dynamic>),
      saved: json['saved'] == null ? null : SavedPostModel.fromJson(json['saved'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedPersonalPostModelToJson(FeedPersonalPostModel instance) => <String, dynamic>{
      'post': instance.post.toJson(),
      'user': instance.user.toJson(),
      'reaction': instance.reaction?.toJson(),
      'saved': instance.saved?.toJson(),
    };

GetPersonalFeedParams _$GetPersonalFeedParamsFromJson(Map<String, dynamic> json) => GetPersonalFeedParams(
      pagination: GetPostsPaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
      userId: json['user_id'] as int,
    );

Map<String, dynamic> _$GetPersonalFeedParamsToJson(GetPersonalFeedParams instance) => <String, dynamic>{
      'pagination': instance.pagination.toJson(),
      'user_id': instance.userId,
    };
