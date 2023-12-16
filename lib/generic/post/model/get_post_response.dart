import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:superkauf/generic/post/model/post_model.dart';
import 'package:superkauf/generic/user/model/user_model.dart';

part 'get_post_response.g.dart';

@JsonSerializable(explicitToJson: true)
class FeedPostModel extends Equatable {
  @JsonKey(name: 'posts')
  final PostModel post;
  @JsonKey(name: 'users')
  final UserModel user;

  const FeedPostModel({
    required this.post,
    required this.user,
  });

  factory FeedPostModel.fromJson(Map<String, dynamic> json) =>
      _$FeedPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedPostModelToJson(this);

  @override
  List<Object?> get props => [
        post,
        user,
      ];
}
