import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:superkauf/generic/post/model/get_posts_body.dart';
import 'package:superkauf/generic/post/model/models/reaction_model.dart';
import 'package:superkauf/generic/post/model/pagination_model.dart';
import 'package:superkauf/generic/post/model/post_model.dart';
import 'package:superkauf/generic/saved_posts/model/saved_post_model.dart';
import 'package:superkauf/generic/user/model/user_model.dart';

part 'get_personal_post_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetPaginatedPostsResponseModel extends Equatable {
  final List<FullContextPostModel> posts;
  final PaginationModel pagination;

  const GetPaginatedPostsResponseModel({
    required this.posts,
    required this.pagination,
  });

  factory GetPaginatedPostsResponseModel.fromJson(Map<String, dynamic> json) => _$GetPaginatedPostsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetPaginatedPostsResponseModelToJson(this);

  @override
  List<Object?> get props => [
        posts,
        pagination,
      ];
}

@JsonSerializable(explicitToJson: true)
class FullContextPostModel extends Equatable {
  final PostModel post;
  final UserModel user;
  final ReactionModel? reaction;
  final SavedPostModel? saved;

  const FullContextPostModel({
    required this.post,
    required this.user,
    required this.reaction,
    required this.saved,
  });

  factory FullContextPostModel.fromJson(Map<String, dynamic> json) => _$FullContextPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$FullContextPostModelToJson(this);

  @override
  List<Object?> get props => [
        post,
        user,
      ];
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetPersonalFeedParams extends Equatable {
  final GetPostsBody body;
  final int userId;

  const GetPersonalFeedParams({
    required this.body,
    required this.userId,
  });

  factory GetPersonalFeedParams.fromJson(Map<String, dynamic> json) => _$GetPersonalFeedParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetPersonalFeedParamsToJson(this);

  @override
  List<Object?> get props => [
        body,
        userId,
      ];
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetTopPostsParams extends Equatable {
  final GetPostsBody body;
  final int userId;
  final int? store;
  final String timeRange;
  final String sortBy;

  const GetTopPostsParams({
    required this.body,
    required this.userId,
    this.store,
    required this.timeRange,
    required this.sortBy,
  });

  factory GetTopPostsParams.fromJson(Map<String, dynamic> json) => _$GetTopPostsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetTopPostsParamsToJson(this);

  @override
  List<Object?> get props => [
        body,
        userId,
      ];
}
