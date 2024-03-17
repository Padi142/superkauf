import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'label_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class LabelModel extends Equatable {
  final String label;
  final String id;

  const LabelModel({
    required this.id,
    required this.label,
  });

  factory LabelModel.fromJson(Map<String, dynamic> json) => _$LabelModelFromJson(json);

  Map<String, dynamic> toJson() => _$LabelModelToJson(this);

  @override
  List<Object?> get props => [
        label,
        id,
      ];
}
