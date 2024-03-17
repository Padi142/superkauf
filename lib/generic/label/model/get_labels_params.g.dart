// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_labels_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLabelsParams _$GetLabelsParamsFromJson(Map<String, dynamic> json) => GetLabelsParams(
      query: json['query'] as String,
      page: json['page'] as int,
      limit: json['limit'] as int,
    );

Map<String, dynamic> _$GetLabelsParamsToJson(GetLabelsParams instance) => <String, dynamic>{
      'query': instance.query,
      'limit': instance.limit,
      'page': instance.page,
    };
