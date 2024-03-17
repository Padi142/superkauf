import 'package:dio/dio.dart';
import 'package:superkauf/generic/api/countries_api.dart';
import 'package:superkauf/generic/countries/model/get_countries_result.dart';

class CountriesRepository {
  final CountriesApi countriesApi;

  CountriesRepository({
    required this.countriesApi,
  });

  Future<GetCountriesResult> getCountries() async {
    return countriesApi.getCountries().then((countries) {
      return GetCountriesResult.success(countries);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetCountriesResult.failure(error.message ?? 'error getting countries');
      }
      return const GetCountriesResult.failure('error getting countries');
    });
  }
}
