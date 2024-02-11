import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_list_response.freezed.dart';

@freezed
class GenericListResponse with _$GenericListResponse {
  const factory GenericListResponse.success() = Success;

  const factory GenericListResponse.failure(String message) = Failure;
}
