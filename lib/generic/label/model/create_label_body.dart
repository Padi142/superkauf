import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_label_body.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CreateLabelBody extends Equatable {
  final String label;
  final int user;
  final int post;

  const CreateLabelBody({
    required this.label,
    required this.user,
    required this.post,
  });

  factory CreateLabelBody.fromJson(Map<String, dynamic> json) => _$CreateLabelBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateLabelBodyToJson(this);

  @override
  List<Object?> get props => [
        label,
        user,
        post,
      ];
}
