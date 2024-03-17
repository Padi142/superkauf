part of 'countries_bloc.dart';

abstract class CountriesEvent extends Equatable {
  const CountriesEvent();

  @override
  List<Object> get props => [];
}

class GetCountries extends CountriesEvent {
  const GetCountries();
}

class SetCountry extends CountriesEvent {
  final CountryModel country;
  const SetCountry({required this.country});
}
