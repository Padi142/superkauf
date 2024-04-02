import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:superkauf/feature/account/bloc/account_bloc.dart';
import 'package:superkauf/feature/feed/view/components/loading_feed_post.dart';
import 'package:superkauf/feature/settings/bloc/settings_bloc.dart';
import 'package:superkauf/feature/settings/bloc/settings_state.dart';
import 'package:superkauf/feature/settings/view/components/socials.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/countries/bloc/countries_bloc.dart';
import 'package:superkauf/generic/countries/view/countries_picker.dart';
import 'package:superkauf/generic/functions.dart';
import 'package:superkauf/generic/widget/app_button.dart';

import '../../../library/app.dart';
import '../../../library/app_screen.dart';

class SettingsScreen extends Screen {
  static const String name = ScreenPath.settingsScreen;

  SettingsScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<UserSettingsBloc>(context).add(const GetSettings());
    BlocProvider.of<CountriesBloc>(context).add(const GetCountries());
    _scrollController.addListener(_listener);

    super.initState();
  }

  var pickedCountry = '';

  void _listener() {
    scrollToRefreshListener(controller: _scrollController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: BlocBuilder<UserSettingsBloc, SettingsState>(
              builder: (context, state) {
                return state.maybeMap(loaded: (loaded) {
                  pickedCountry = loaded.settings.country.code;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 40,
                        child: AppButton(
                          text: 'Change pfp',
                          radius: 8,
                          backgroundColor: Colors.black,
                          elevation: 4,
                          textStyle: App.appTheme.textTheme.titleMedium!.copyWith(color: Colors.white),
                          onClick: () {
                            BlocProvider.of<AccountBloc>(context).add(const ChangeProfilePic(user: null));
                          },
                        ),
                      ),
                      const Gap(20),
                      const Text('Change the country of posts and stores'),
                      const Gap(2),
                      CountriesPicker(
                        pickedCountry: pickedCountry,
                        onCountryPicked: (value) {
                          Future.delayed(const Duration(milliseconds: 500)).then((value) {
                            BlocProvider.of<UserSettingsBloc>(context).add(const GetSettings());
                          });

                          pickedCountry = value;
                          setState(() {});
                        },
                      ),
                      const Gap(200),
                      const SocialsPanel(),
                    ],
                  );
                }, error: (error) {
                  return Center(child: Text(error.error));
                }, orElse: () {
                  return const PostLoadingView();
                });
              },
            ),
          );
        }));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }
}
