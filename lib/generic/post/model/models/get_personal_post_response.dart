import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:superkauf/generic/post/model/models/reaction_model.dart';
import 'package:superkauf/generic/post/model/pagination_model.dart';
import 'package:superkauf/generic/post/model/post_model.dart';
import 'package:superkauf/generic/saved_posts/model/saved_post_model.dart';
import 'package:superkauf/generic/user/model/user_model.dart';

part 'get_personal_post_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetPersonalFeedResponseModel extends Equatable {
  final List<FeedPersonalPostModel> posts;
  final PaginationModel pagination;

  const GetPersonalFeedResponseModel({
    required this.posts,
    required this.pagination,
  });

  factory GetPersonalFeedResponseModel.fromJson(Map<String, dynamic> json) => _$GetPersonalFeedResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetPersonalFeedResponseModelToJson(this);

  @override
  List<Object?> get props => [
        posts,
        pagination,
      ];
}

@JsonSerializable(explicitToJson: true)
class FeedPersonalPostModel extends Equatable {
  final PostModel post;
  final UserModel user;
  final ReactionModel? reaction;
  final SavedPostModel? saved;

  const FeedPersonalPostModel({
    required this.post,
    required this.user,
    required this.reaction,
    required this.saved,
  });

  factory FeedPersonalPostModel.fromJson(Map<String, dynamic> json) => _$FeedPersonalPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedPersonalPostModelToJson(this);

  @override
  List<Object?> get props => [
        post,
        user,
      ];
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetPersonalFeedParams extends Equatable {
  final GetPostsPaginationModel pagination;
  final int userId;

  const GetPersonalFeedParams({
    required this.pagination,
    required this.userId,
  });

  factory GetPersonalFeedParams.fromJson(Map<String, dynamic> json) => _$GetPersonalFeedParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetPersonalFeedParamsToJson(this);

  @override
  List<Object?> get props => [
        pagination,
        userId,
      ];
}
