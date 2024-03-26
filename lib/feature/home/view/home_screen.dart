import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_state.dart';
import 'package:superkauf/feature/home/bloc/saved_posts_panel_bloc/saved_posts_panel_bloc.dart';
import 'package:superkauf/feature/home/bloc/saved_posts_panel_bloc/saved_posts_panel_state.dart';
import 'package:superkauf/feature/snackbar/bloc/snackbar_bloc.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/notifications/presentation/check_notifications_bloc.dart';
import 'package:superkauf/generic/notifications/presentation/check_notifications_state.dart';
import 'package:superkauf/generic/widget/panels/save_post_panel.dart';
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
    BlocProvider.of<CheckNotificationBloc>(context)
        .add(const CheckNotifications());
    super.initState();
  }

  final PanelController _postSavedPanel = PanelController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SnackbarBloc, SnackbarState>(
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
      child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
        switch (state) {
          case final NavigationStateLoaded loaded:
            return SlidingUpPanel(
              controller: _postSavedPanel,
              backdropEnabled: true,
              backdropOpacity: 0.8,
              borderRadius: BorderRadius.circular(16),
              minHeight: 0,
              maxHeight: 400,
              panelBuilder: (ScrollController sc) {
                return SavePostPanel(panelController: _postSavedPanel);
              },
              body: Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                appBar: AppBar(
                  title: Text('app_title'.tr()),
                  leading: BlocBuilder<CheckNotificationBloc,
                      CheckNotificationsState>(
                    builder: (context, state) {
                      return state.maybeMap(success: (success) {
                        if (success.notifications.newNotifications) {
                          return IconButton(
                            onPressed: () {
                              BlocProvider.of<NavigationBloc>(context)
                                  .add(const OpenMyNotificationsScreen());
                              BlocProvider.of<CheckNotificationBloc>(context)
                                  .add(const ClearNotifications());
                            },
                            icon: Badge(
                                alignment: Alignment.topRight,
                                label: Text(
                                  success.notifications.notificationCount
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                child: const Icon(Icons.notifications)),
                          );
                        }
                        return IconButton(
                          onPressed: () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(const OpenMyNotificationsScreen());
                          },
                          icon: const Icon(Icons.notifications),
                        );
                      }, orElse: () {
                        return IconButton(
                          onPressed: () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(const OpenMyNotificationsScreen());
                          },
                          icon: const Icon(Icons.notifications),
                        );
                      });
                    },
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<NavigationBloc>(context)
                            .add(const OpenProfileScreen());
                      },
                      icon: const Icon(Icons.person),
                    ),
                  ],
                ),
                bottomNavigationBar: NavigationBar(
                  backgroundColor: App.appTheme.colorScheme.secondary,
                  indicatorColor: App.appTheme.colorScheme.surface,
                  height: 60,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                  onDestinationSelected: (index) {
                    switch (index) {
                      case 0:
                        BlocProvider.of<NavigationBloc>(context)
                            .add(OpenFeedScreen(index));
                        break;
                      case 1:
                        BlocProvider.of<NavigationBloc>(context)
                            .add(OpenSearchScreen(index));
                        break;
                      case 2:
                        BlocProvider.of<NavigationBloc>(context)
                            .add(GoToCreatePostScreen(index));
                        break;
                      case 3:
                        BlocProvider.of<NavigationBloc>(context)
                            .add(OpenDiscoverScreen(index));
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
                      selectedIcon: Icon(Icons.search),
                      icon: Icon(Icons.search),
                      label: 'Search',
                    ),
                    NavigationDestination(
                      selectedIcon: Icon(Icons.add),
                      icon: Icon(Icons.add),
                      label: 'Create',
                    ),
                    NavigationDestination(
                      selectedIcon: Icon(Icons.list),
                      icon: Icon(Icons.list_outlined),
                      label: 'Discover',
                    ),
                    NavigationDestination(
                      selectedIcon: Icon(Icons.shopping_basket),
                      icon: Icon(Icons.shopping_basket_outlined),
                      label: 'Saved',
                    ),
                  ],
                  selectedIndex: loaded.bottomNavIndex,
                ),
                body: BlocListener<SavedPostsPanelBloc, SavedPostsPanelState>(
                  listener: (context, state) {
                    state.maybeMap(
                      openSavedPostPanel: (_) {
                        _postSavedPanel.open();
                      },
                      orElse: () {},
                    );
                  },
                  child: AppNavigation().pathContent(
                    state.screenName,
                    params: loaded.params,
                  ),
                ),
              ),
            );
          default:
            return Container();
        }
      }),
    );
  }
}
