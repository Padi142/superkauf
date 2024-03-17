import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/label/model/label_model.dart';

part 'get_labels_result.freezed.dart';

@freezed
class GetLabelsResult with _$GetLabelsResult {
  const factory GetLabelsResult.success(List<LabelModel> labels) = Success;

  const factory GetLabelsResult.failure(String message) = Failure;
}
