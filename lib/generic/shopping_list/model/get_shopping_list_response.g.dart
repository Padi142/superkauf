// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_shopping_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetShoppingListResponse _$GetShoppingListResponseFromJson(Map<String, dynamic> json) => GetShoppingListResponse(
      list: ShoppingListModel.fromJson(json['list'] as Map<String, dynamic>),
      users: (json['users'] as List<dynamic>).map((e) => UserModel.fromJson(e as Map<String, dynamic>)).toList(),
      posts: (json['posts'] as List<dynamic>).map((e) => ShoppingListPost.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$GetShoppingListResponseToJson(GetShoppingListResponse instance) => <String, dynamic>{
      'list': instance.list.toJson(),
      'users': instance.users.map((e) => e.toJson()).toList(),
      'posts': instance.posts.map((e) => e.toJson()).toList(),
    };

ShoppingListPost _$ShoppingListPostFromJson(Map<String, dynamic> json) => ShoppingListPost(
      post: SavedPostWithContext.fromJson(json['post'] as Map<String, dynamic>),
      addedBy: UserModel.fromJson(json['added_by'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShoppingListPostToJson(ShoppingListPost instance) => <String, dynamic>{
      'post': instance.post.toJson(),
      'added_by': instance.addedBy.toJson(),
    };

SavedPostWithContext _$SavedPostWithContextFromJson(Map<String, dynamic> json) => SavedPostWithContext(
      post: PostModel.fromJson(json['post'] as Map<String, dynamic>),
      savedPost: SavedPostModel.fromJson(json['saved_post'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SavedPostWithContextToJson(SavedPostWithContext instance) => <String, dynamic>{
      'post': instance.post.toJson(),
      'saved_post': instance.savedPost.toJson(),
    };
