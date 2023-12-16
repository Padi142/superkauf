import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_state.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/library/app_navigation.dart';

import '../../../library/app_screen.dart';

class HomeScreen extends Screen {
  static const String name = ScreenPath.homeScreen;

  HomeScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
        switch (state) {
          case final NavigationStateLoaded loaded:
            return Scaffold(
              appBar: AppBar(
                title: Text('app_title'.tr()),
              ),
              bottomNavigationBar: NavigationBar(
                onDestinationSelected: (index) {
                  switch (index) {
                    case 0:
                      BlocProvider.of<NavigationBloc>(context)
                          .add(OpenFeedScreen(index));
                      break;
                    case 1:
                      BlocProvider.of<NavigationBloc>(context)
                          .add(OpenStoresScreen(index));
                      break;
                    case 2:
                      BlocProvider.of<NavigationBloc>(context)
                          .add(OpenDiscoverScreen(index));
                      break;
                    case 3:
                      BlocProvider.of<NavigationBloc>(context)
                          .add(OpenMyChannelScreen(index));
                      break;
                    case 4:
                      BlocProvider.of<NavigationBloc>(context)
                          .add(OpenShoppingListScreen(index));
                      break;
                    default:
                      break;
                  }
                },
                destinations: const [
                  NavigationDestination(
                    selectedIcon: Icon(Icons.home),
                    icon: Icon(Icons.home_outlined),
                    label: 'Feed',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(Icons.storefront_rounded),
                    icon: Icon(Icons.storefront),
                    label: 'Stores',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(Icons.list),
                    icon: Icon(Icons.list_outlined),
                    label: 'Discover',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(Icons.forum),
                    icon: Icon(Icons.forum_outlined),
                    label: 'My Channel',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(Icons.shopping_basket),
                    icon: Icon(Icons.shopping_basket_outlined),
                    label: 'My Channel',
                  ),
                ],
                selectedIndex: loaded.bottomNavIndex,
              ),
              body: AppNavigation().pathContent(
                state.screenName,
              ),
            );
          default:
            return Container();
        }
      }),
    );
  }
}
