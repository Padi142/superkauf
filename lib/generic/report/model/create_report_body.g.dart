// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_report_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateReportBody _$CreateReportBodyFromJson(Map<String, dynamic> json) => CreateReportBody(
      reportedComment: json['reported_comment'] as int?,
      reportedPost: json['reported_post'] as int?,
      reportedBy: json['reported_by'] as int,
      type: json['type'] as String,
    );

Map<String, dynamic> _$CreateReportBodyToJson(CreateReportBody instance) => <String, dynamic>{
      'reported_comment': instance.reportedComment,
      'reported_post': instance.reportedPost,
      'reported_by': instance.reportedBy,
      'type': instance.type,
    };
