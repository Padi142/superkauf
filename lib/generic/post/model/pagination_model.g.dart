// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) => PaginationModel(
      perPage: json['per_page'] as int,
      count: json['count'] as int,
    );

Map<String, dynamic> _$PaginationModelToJson(PaginationModel instance) => <String, dynamic>{
      'per_page': instance.perPage,
      'count': instance.count,
    };

GetPostsPaginationModel _$GetPostsPaginationModelFromJson(Map<String, dynamic> json) => GetPostsPaginationModel(
      perPage: json['per_page'] as int,
      offset: json['offset'] as int,
    );

Map<String, dynamic> _$GetPostsPaginationModelToJson(GetPostsPaginationModel instance) => <String, dynamic>{
      'per_page': instance.perPage,
      'offset': instance.offset,
    };
