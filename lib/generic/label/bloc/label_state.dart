import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/label/model/label_model.dart';

part 'label_state.freezed.dart';

@freezed
abstract class LabelState with _$LabelState {
  const factory LabelState.loading() = Loading;

  const factory LabelState.loaded(List<LabelModel> labels) = Loaded;

  const factory LabelState.error(String error) = Error;
}
