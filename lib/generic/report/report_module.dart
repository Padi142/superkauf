import 'package:get_it/get_it.dart';
import 'package:superkauf/generic/api/report_api.dart';
import 'package:superkauf/generic/report/data/report_repository.dart';
import 'package:superkauf/generic/report/user_case/create_report_use_case.dart';
import 'package:superkauf/library/app_module.dart';

class ReportModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerRepo() {
    GetIt.I.registerFactory<ReportRepository>(
      () => ReportRepository(
        reportAPi: GetIt.I.get<ReportApi>(),
      ),
    );
  }

  @override
  void registerBloc() {}

  @override
  void registerScreen() {}

  @override
  void registerUseCase() {
    GetIt.I.registerFactory<CreateReportUseCase>(
      () => CreateReportUseCase(repository: GetIt.I.get<ReportRepository>()),
    );
  }

  @override
  void registerDI() {}
}
