import 'package:superkauf/generic/report/data/report_repository.dart';
import 'package:superkauf/generic/report/model/create_report_body.dart';
import 'package:superkauf/generic/report/model/create_report_result.dart';
import 'package:superkauf/library/use_case.dart';

class CreateReportUseCase extends UseCase<CreateReportResult, CreateReportBody> {
  ReportRepository repository;

  CreateReportUseCase({
    required this.repository,
  });

  @override
  Future<CreateReportResult> call(params) async {
    return await repository.createReport(params);
  }
}
