import 'package:dio/dio.dart';
import 'package:superkauf/generic/api/report_api.dart';
import 'package:superkauf/generic/report/model/create_report_body.dart';
import 'package:superkauf/generic/report/model/create_report_result.dart';

class ReportRepository {
  final ReportApi reportAPi;

  ReportRepository({
    required this.reportAPi,
  });

  Future<CreateReportResult> createReport(CreateReportBody body) async {
    return reportAPi.createReport(body: body.toJson()).then((comment) {
      return const CreateReportResult.success();
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return CreateReportResult.failure(error.message ?? 'error deleting comment');
      }
      return const CreateReportResult.failure('error');
    });
  }
}
