// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) => NotificationModel(
      text: json['text'] as String,
      recipientId: json['recipient_id'] as int,
      relatedPostId: json['related_post_id'] as int,
      relatedUserId: json['related_user_id'] as int,
      seen: json['seen'] as bool,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      createdAt: DateTime.parse(json['created_at'] as String),
      relatedPost: PostModel.fromJson(json['related_post'] as Map<String, dynamic>),
      relatedUser: UserModel.fromJson(json['related_user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) => <String, dynamic>{
      'text': instance.text,
      'recipient_id': instance.recipientId,
      'related_post_id': instance.relatedPostId,
      'related_user_id': instance.relatedUserId,
      'seen': instance.seen,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'created_at': instance.createdAt.toIso8601String(),
      'related_post': instance.relatedPost.toJson(),
      'related_user': instance.relatedUser.toJson(),
    };

const _$NotificationTypeEnumMap = {
  NotificationType.post_like: 'post_like',
  NotificationType.post_comment: 'post_comment',
  NotificationType.post_like_count: 'post_like_count',
  NotificationType.none: 'none',
  NotificationType.generic: 'generic',
};
