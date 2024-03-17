import 'package:superkauf/generic/label/model/get_labels_params.dart';
import 'package:superkauf/generic/label/model/get_labels_result.dart';
import 'package:superkauf/generic/label/repository/label_repository.dart';
import 'package:superkauf/library/use_case.dart';

class GetLabelsUseCase extends UseCase<GetLabelsResult, GetLabelsParams> {
  LabelRepository repository;

  GetLabelsUseCase({
    required this.repository,
  });

  @override
  Future<GetLabelsResult> call(params) async {
    return await repository.getLabels(params);
  }
}
