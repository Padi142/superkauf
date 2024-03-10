import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/post/model/post_model.dart';
import 'package:superkauf/generic/user/model/user_model.dart';

part 'notification_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class NotificationModel extends Equatable {
  final int id;
  final String text;
  final int recipientId;
  final int? relatedPostId;
  final int? relatedUserId;
  final bool seen;
  final NotificationType type;
  final DateTime createdAt;
  final PostModel? relatedPost;
  final UserModel? relatedUser;

  const NotificationModel({
    required this.id,
    required this.text,
    required this.recipientId,
    required this.relatedPostId,
    required this.relatedUserId,
    required this.seen,
    required this.type,
    required this.createdAt,
    required this.relatedPost,
    required this.relatedUser,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  List<Object?> get props => [
        type,
        text,
        recipientId,
        relatedPostId,
        relatedUserId,
        seen,
        createdAt,
        relatedPost,
        relatedUser,
      ];
}

enum NotificationType {
  post_like,
  post_comment,
  post_like_count,
  none,
  highlight,
  generic,
}
