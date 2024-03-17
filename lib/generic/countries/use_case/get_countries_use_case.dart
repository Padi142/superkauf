import 'package:superkauf/generic/countries/data/countries_repository.dart';
import 'package:superkauf/generic/countries/model/get_countries_result.dart';
import 'package:superkauf/library/use_case.dart';

class GetCountriesUseCase extends UnitUseCase<GetCountriesResult> {
  CountriesRepository repository;

  GetCountriesUseCase({
    required this.repository,
  });

  @override
  Future<GetCountriesResult> call() async {
    return await repository.getCountries();
  }
}
