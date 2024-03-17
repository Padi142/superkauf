import 'package:get_it/get_it.dart';
import 'package:superkauf/generic/api/label_api.dart';
import 'package:superkauf/generic/label/bloc/label_bloc.dart';
import 'package:superkauf/generic/label/repository/label_repository.dart';
import 'package:superkauf/generic/label/use_case/create_label_use_case.dart';
import 'package:superkauf/generic/label/use_case/get_labels_use_case.dart';
import 'package:superkauf/library/app_module.dart';

class LabelModule extends AppModule {
  @override
  void registerNavigation() {}

  @override
  void registerRepo() {
    GetIt.I.registerFactory<LabelRepository>(
      () => LabelRepository(
        labelApi: GetIt.I.get<LabelApi>(),
      ),
    );
  }

  @override
  void registerBloc() {
    GetIt.I.registerFactory<LabelBloc>(
      () => LabelBloc(
        getLabelsUseCase: GetIt.I.get<GetLabelsUseCase>(),
      ),
    );
  }

  @override
  void registerScreen() {}

  @override
  void registerUseCase() {
    GetIt.I.registerFactory<GetLabelsUseCase>(
      () => GetLabelsUseCase(repository: GetIt.I.get<LabelRepository>()),
    );

    GetIt.I.registerFactory<CreateLabelUseCase>(
      () => CreateLabelUseCase(repository: GetIt.I.get<LabelRepository>()),
    );
  }

  @override
  void registerDI() {}
}
