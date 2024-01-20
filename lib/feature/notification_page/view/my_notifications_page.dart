import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/feed/view/components/loading_feed_post.dart';
import 'package:superkauf/feature/notification_page/bloc/my_notifications_bloc.dart';
import 'package:superkauf/feature/notification_page/bloc/my_notifications_state.dart';
import 'package:superkauf/feature/notification_page/view/component/notification_container.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/functions.dart';

import '../../../library/app_screen.dart';

class MyNotificationsScreen extends Screen {
  static const String name = ScreenPath.myNotificationsScreen;

  MyNotificationsScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _MyNotificationsScreenState();
}

class _MyNotificationsScreenState extends State<MyNotificationsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<MyNotificationsBloc>(context).add(const GetNotifications());
    _scrollController.addListener(_listener);

    super.initState();
  }

  void _listener() {
    scrollToRefreshListener(controller: _scrollController);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<MyNotificationsBloc>().add(
                        const GetNotifications(),
                      );
                },
                child: Column(
                  children: [
                    BlocBuilder<MyNotificationsBloc, MyNotificationsState>(
                      builder: (context, state) {
                        return state.maybeMap(loaded: (loaded) {
                          if (loaded.notifications.isEmpty) {
                            return Center(
                                child: Column(
                              children: [
                                Text(
                                  'no_notifications_for_user_1'.tr(),
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('no_notifications_for_user_2'.tr(), style: Theme.of(context).textTheme.titleSmall),
                              ],
                            ));
                          }
                          return SizedBox(
                            height: constraints.maxHeight,
                            child: ListView.builder(
                              itemCount: loaded.notifications.length,
                              controller: _scrollController,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: loaded.notifications.length == index + 1 ? 100 : 0),
                                  child: NotificationContainer(
                                    notification: loaded.notifications[index],
                                  ),
                                );
                              },
                            ),
                          );
                        }, error: (error) {
                          return Center(child: Text(error.error));
                        }, orElse: () {
                          return const PostLoadingView();
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }
}
