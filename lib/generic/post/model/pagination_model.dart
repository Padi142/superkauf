import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PaginationModel extends Equatable {
  final int perPage;
  final int count;

  const PaginationModel({
    required this.perPage,
    required this.count,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) => _$PaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);

  @override
  List<Object?> get props => [
        perPage,
        count,
      ];
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetPostsPaginationModel extends Equatable {
  final int perPage;
  final int offset;

  const GetPostsPaginationModel({
    required this.perPage,
    required this.offset,
  });

  factory GetPostsPaginationModel.fromJson(Map<String, dynamic> json) => _$GetPostsPaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostsPaginationModelToJson(this);

  @override
  List<Object?> get props => [
        perPage,
        offset,
      ];
}
