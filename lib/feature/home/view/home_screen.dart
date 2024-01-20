import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_state.dart';
import 'package:superkauf/feature/snackbar/bloc/snackbar_bloc.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/notifications/presentation/check_notifications_bloc.dart';
import 'package:superkauf/generic/notifications/presentation/check_notifications_state.dart';
import 'package:superkauf/library/app.dart';
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
    BlocProvider.of<CheckNotificationBloc>(context).add(const CheckNotifications());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<SnackbarBloc, SnackbarState>(
        listener: (context, state) async {
          if (state is ErrorSnackbarState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
          if (state is SuccessSnackbarState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.greenAccent,
              ),
            );
          }
          if (state is InfoSnackbarState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.blueAccent,
              ),
            );
          }
        },
        child: BlocBuilder<NavigationBloc, NavigationState>(builder: (context, state) {
          switch (state) {
            case final NavigationStateLoaded loaded:
              return Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                appBar: AppBar(
                  title: Text('app_title'.tr()),
                  leading: BlocBuilder<CheckNotificationBloc, CheckNotificationsState>(
                    builder: (context, state) {
                      return state.maybeMap(success: (success) {
                        if (success.notifications.newNotifications) {
                          return IconButton(
                            onPressed: () {
                              BlocProvider.of<NavigationBloc>(context).add(const OpenMyNotificationsScreen());
                              BlocProvider.of<CheckNotificationBloc>(context).add(const ClearNotifications());
                            },
                            icon: Badge(
                                alignment: Alignment.topRight,
                                label: Text(
                                  success.notifications.notificationCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                child: const Icon(Icons.notifications)),
                          );
                        }
                        return IconButton(
                          onPressed: () {
                            BlocProvider.of<NavigationBloc>(context).add(const OpenMyNotificationsScreen());
                          },
                          icon: const Icon(Icons.notifications),
                        );
                      }, orElse: () {
                        return IconButton(
                          onPressed: () {
                            BlocProvider.of<NavigationBloc>(context).add(const OpenMyNotificationsScreen());
                          },
                          icon: const Icon(Icons.notifications),
                        );
                      });
                    },
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<NavigationBloc>(context).add(const OpenProfileScreen());
                      },
                      icon: const Icon(Icons.person),
                    ),
                  ],
                ),
                bottomNavigationBar: NavigationBar(
                  backgroundColor: App.appTheme.colorScheme.secondary,
                  indicatorColor: App.appTheme.colorScheme.surface,
                  onDestinationSelected: (index) {
                    switch (index) {
                      case 0:
                        BlocProvider.of<NavigationBloc>(context).add(OpenFeedScreen(index));
                        break;
                      case 1:
                        BlocProvider.of<NavigationBloc>(context).add(OpenStoresScreen(index));
                        break;
                      case 2:
                        BlocProvider.of<NavigationBloc>(context).add(OpenDiscoverScreen(index));
                        break;
                      case 3:
                        BlocProvider.of<NavigationBloc>(context).add(OpenMyChannelScreen(index));
                        break;
                      case 4:
                        BlocProvider.of<NavigationBloc>(context).add(OpenShoppingListScreen(index));
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
                      label: 'Saved',
                    ),
                  ],
                  selectedIndex: loaded.bottomNavIndex,
                ),
                body: AppNavigation().pathContent(
                  state.screenName,
                  params: loaded.params,
                ),
              );
            default:
              return Container();
          }
        }),
      ),
    );
  }
}
