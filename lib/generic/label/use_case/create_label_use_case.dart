import 'package:superkauf/generic/label/model/create_label_body.dart';
import 'package:superkauf/generic/label/model/get_labels_result.dart';
import 'package:superkauf/generic/label/repository/label_repository.dart';
import 'package:superkauf/library/use_case.dart';

class CreateLabelUseCase extends UseCase<GetLabelsResult, CreateLabelBody> {
  LabelRepository repository;

  CreateLabelUseCase({
    required this.repository,
  });

  @override
  Future<GetLabelsResult> call(params) async {
    return await repository.createLabel(params);
  }
}
