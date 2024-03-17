// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_label_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateLabelBody _$CreateLabelBodyFromJson(Map<String, dynamic> json) => CreateLabelBody(
      label: json['label'] as String,
      user: json['user'] as int,
      post: json['post'] as int,
    );

Map<String, dynamic> _$CreateLabelBodyToJson(CreateLabelBody instance) => <String, dynamic>{
      'label': instance.label,
      'user': instance.user,
      'post': instance.post,
    };
