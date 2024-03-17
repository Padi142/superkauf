import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_labels_params.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetLabelsParams extends Equatable {
  final String query;
  final int limit;
  final int page;

  const GetLabelsParams({
    required this.query,
    required this.page,
    required this.limit,
  });

  factory GetLabelsParams.fromJson(Map<String, dynamic> json) => _$GetLabelsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetLabelsParamsToJson(this);

  @override
  List<Object?> get props => [
        query,
        limit,
        page,
      ];
}
