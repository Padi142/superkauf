import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/post_model.dart';
import 'package:superkauf/generic/shopping_list/model/shopping_list_model.dart';
import 'package:superkauf/generic/user/model/user_model.dart';

part 'get_shopping_list_response.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetShoppingListResponse extends Equatable {
  final ShoppingListModel list;
  final List<UserModel> users;
  final List<ShoppingLisPost> posts;

  const GetShoppingListResponse({
    required this.list,
    required this.users,
    required this.posts,
  });

  factory GetShoppingListResponse.fromJson(Map<String, dynamic> json) => _$GetShoppingListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetShoppingListResponseToJson(this);

  @override
  List<Object?> get props => [
        list,
        users,
        posts,
      ];
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ShoppingLisPost extends Equatable {
  final PostModel post;
  final UserModel addedBy;

  const ShoppingLisPost({
    required this.post,
    required this.addedBy,
  });

  factory ShoppingLisPost.fromJson(Map<String, dynamic> json) => _$ShoppingLisPostFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingLisPostToJson(this);

  @override
  List<Object?> get props => [
        post,
        addedBy,
      ];
}
