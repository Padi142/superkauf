import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/store/model/store_model.dart';

part 'store_state.freezed.dart';

@freezed
abstract class StoreState with _$StoreState {
  const factory StoreState.loading() = Loading;

  const factory StoreState.success(List<StoreModel> stores) = Success;

  const factory StoreState.error(String error) = Error;
}
