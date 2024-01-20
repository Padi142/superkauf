// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckNotificationResponse _$CheckNotificationResponseFromJson(Map<String, dynamic> json) => CheckNotificationResponse(
      newNotifications: json['new_notifications'] as bool,
      notificationCount: json['notification_count'] as int,
    );

Map<String, dynamic> _$CheckNotificationResponseToJson(CheckNotificationResponse instance) => <String, dynamic>{
      'new_notifications': instance.newNotifications,
      'notification_count': instance.notificationCount,
    };
