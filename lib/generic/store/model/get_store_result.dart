import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/store/model/store_model.dart';

part 'get_store_result.freezed.dart';

@freezed
class GetStoreResult with _$GetStoreResult {
  const factory GetStoreResult.success(StoreModel store) = Success;

  const factory GetStoreResult.failure(String message) = Failure;
}
