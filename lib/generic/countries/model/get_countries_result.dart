import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/countries/model/country_model.dart';

part 'get_countries_result.freezed.dart';

@freezed
class GetCountriesResult with _$GetCountriesResult {
  const factory GetCountriesResult.success(List<CountryModel> countries) = Success;

  const factory GetCountriesResult.failure(String message) = Failure;
}
