import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/store/model/store_model.dart';

part 'get_stores_result.freezed.dart';

@freezed
class GetStoresResult with _$GetStoresResult {
  const factory GetStoresResult.success(List<StoreModel> stores) = Success;

  const factory GetStoresResult.failure(String message) = Failure;
}
