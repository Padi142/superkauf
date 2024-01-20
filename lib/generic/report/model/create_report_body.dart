import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_report_body.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CreateReportBody extends Equatable {
  final int? reportedComment;
  final int? reportedPost;
  final int reportedBy;
  final String type;

  const CreateReportBody({
    this.reportedComment,
    this.reportedPost,
    required this.reportedBy,
    required this.type,
  });

  factory CreateReportBody.fromJson(Map<String, dynamic> json) => _$CreateReportBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateReportBodyToJson(this);

  @override
  List<Object?> get props => [
        type,
        reportedComment,
        reportedPost,
        reportedBy,
      ];
}
