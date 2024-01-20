import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_report_result.freezed.dart';

@freezed
class CreateReportResult with _$CreateReportResult {
  const factory CreateReportResult.success() = Success;

  const factory CreateReportResult.failure(String message) = Failure;
}
