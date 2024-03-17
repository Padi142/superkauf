import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/generic/countries/bloc/countries_bloc.dart';
import 'package:superkauf/generic/countries/bloc/countries_state.dart';
import 'package:superkauf/generic/widget/app_button.dart';
import 'package:superkauf/library/app.dart';

class CountriesPicker extends StatelessWidget {
  final String? pickedCountry;
  final Function(String) onCountryPicked;
  const CountriesPicker({
    super.key,
    required this.pickedCountry,
    required this.onCountryPicked,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountriesBloc, CountriesState>(builder: (context, state) {
      return state.maybeMap(orElse: () {
        return const CardLoading(
          width: 120,
          height: 40,
        );
      }, loaded: (loaded) {
        return SizedBox(
          width: 120,
          height: 40,
          child: AppButton(
            elevation: 16,
            popupMenu: loaded.countries.map((it) => PopupOption<String>(value: it.code, title: it.name)).toList(),
            text: pickedCountry ?? 'Country',
            textStyle: App.appTheme.textTheme.titleMedium!.copyWith(),
            backgroundColor: App.appTheme.colorScheme.surface,
            onSelectPopup: (value) {
              BlocProvider.of<CountriesBloc>(context).add(SetCountry(country: loaded.countries.firstWhere((element) => element.code == value.value)));
              // BlocProvider.of<FeedBloc>(context).add(const GetFeed());
              onCountryPicked(value.title);
            },
            radius: 8,
          ),
        );
      });
    });
  }
}
