import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/generic/countries/model/country_model.dart';

part 'countries_state.freezed.dart';

@freezed
abstract class CountriesState with _$CountriesState {
  const factory CountriesState.loading() = Loading;

  const factory CountriesState.loaded(List<CountryModel> countries) = Loaded;

  const factory CountriesState.error(String error) = Error;
}
