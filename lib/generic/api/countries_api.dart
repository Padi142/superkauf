import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:superkauf/generic/countries/model/country_model.dart';

part 'countries_api.g.dart';

@RestApi()
abstract class CountriesApi {
  factory CountriesApi(Dio dio) = _CountriesApi;

  @GET('/countries')
  Future<List<CountryModel>> getCountries();
}
