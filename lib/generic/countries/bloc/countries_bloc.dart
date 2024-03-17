import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/generic/countries/model/country_model.dart';
import 'package:superkauf/generic/countries/use_case/get_countries_use_case.dart';
import 'package:superkauf/generic/settings/use_case/get_settings_use_case.dart';
import 'package:superkauf/generic/settings/use_case/update_settings_use_case.dart';

import 'countries_state.dart';

part 'countries_event.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final GetCountriesUseCase getCountriesUseCase;
  final UpdateSettingsUseCase updateSettingsUseCase;
  final GetSettingsUseCase getSettingsUseCase;

  CountriesBloc({
    required this.getCountriesUseCase,
    required this.updateSettingsUseCase,
    required this.getSettingsUseCase,
  }) : super(const CountriesState.loading()) {
    on<GetCountries>(_onGetCountries);
    on<SetCountry>(_onSetCountry);
  }

  var userId = -1;

  Future<void> _onGetCountries(
    GetCountries event,
    Emitter<CountriesState> emit,
  ) async {
    emit(const CountriesState.loading());

    final response = await getCountriesUseCase.call();

    response.map(
      failure: (error) => emit(CountriesState.error(error.message)),
      success: (countries) => emit(CountriesState.loaded(countries.countries)),
    );
  }

  Future<void> _onSetCountry(
    SetCountry event,
    Emitter<CountriesState> emit,
  ) async {
    var settings = await getSettingsUseCase.call();

    settings = settings.copyWith(country: event.country);

    print(settings);
    final response = await updateSettingsUseCase.call(settings);
  }
}
