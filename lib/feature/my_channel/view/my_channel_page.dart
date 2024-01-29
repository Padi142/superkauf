import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/feed/view/components/feed_post_container.dart';
import 'package:superkauf/feature/feed/view/components/loading_feed_post.dart';
import 'package:superkauf/feature/my_channel/bloc/my_channel_bloc.dart';
import 'package:superkauf/feature/my_channel/bloc/my_channel_state.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/functions.dart';
import 'package:superkauf/library/app.dart';

import '../../../library/app_screen.dart';

class MyChannelScreen extends Screen {
  static const String name = ScreenPath.myChannelScreen;

  MyChannelScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _MyChannelState();
}

class _MyChannelState extends State<MyChannelScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<MyChannelBloc>(context).add(const GetPosts());
    _scrollController.addListener(_listener);

    super.initState();
  }

  void _listener() {
    scrollToRefreshListener(controller: _scrollController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: FloatingActionButton(
          backgroundColor: App.appTheme.colorScheme.primary,
          onPressed: () {
            // BlocProvider.of<NavigationBloc>(context).add(const GoToCreatePostScreen());
          },
          child: const Icon(Icons.add),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<MyChannelBloc>().add(
                      const GetPosts(),
                    );
              },
              child: Column(
                children: [
                  BlocBuilder<MyChannelBloc, MyChannelState>(
                    builder: (context, state) {
                      return state.maybeMap(loaded: (loaded) {
                        if (loaded.posts.isEmpty) {
                          return Center(
                              child: Column(
                            children: [
                              Text(
                                'no_posts_for_user_1'.tr(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('no_posts_for_user_2'.tr(), style: Theme.of(context).textTheme.titleSmall),
                            ],
                          ));
                        }
                        return SizedBox(
                          height: constraints.maxHeight,
                          child: ListView.builder(
                            itemCount: loaded.posts.length,
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: loaded.posts.length == index + 1 ? 100 : 0),
                                child: FeedPostContainer(
                                  post: loaded.posts[index],
                                  originScreen: ScreenPath.myChannelScreen,
                                  isPersonal: false,
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
        }));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }
}
