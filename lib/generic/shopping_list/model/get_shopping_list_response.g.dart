// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_shopping_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetShoppingListResponse _$GetShoppingListResponseFromJson(Map<String, dynamic> json) => GetShoppingListResponse(
      list: ShoppingListModel.fromJson(json['list'] as Map<String, dynamic>),
      users: (json['users'] as List<dynamic>).map((e) => UserModel.fromJson(e as Map<String, dynamic>)).toList(),
      posts: (json['posts'] as List<dynamic>).map((e) => ShoppingLisPost.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$GetShoppingListResponseToJson(GetShoppingListResponse instance) => <String, dynamic>{
      'list': instance.list.toJson(),
      'users': instance.users.map((e) => e.toJson()).toList(),
      'posts': instance.posts.map((e) => e.toJson()).toList(),
    };

ShoppingLisPost _$ShoppingLisPostFromJson(Map<String, dynamic> json) => ShoppingLisPost(
      post: PostModel.fromJson(json['post'] as Map<String, dynamic>),
      addedBy: UserModel.fromJson(json['added_by'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShoppingLisPostToJson(ShoppingLisPost instance) => <String, dynamic>{
      'post': instance.post.toJson(),
      'added_by': instance.addedBy.toJson(),
    };
