import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/discover/bloc/discover_bloc.dart';
import 'package:superkauf/feature/discover/bloc/discover_state.dart';
import 'package:superkauf/feature/feed/view/components/feed_post_container.dart';
import 'package:superkauf/feature/feed/view/components/loading_feed_post.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/functions.dart';

import '../../../library/app_screen.dart';

class DiscoverScreen extends Screen {
  static const String name = ScreenPath.discoverScreen;

  DiscoverScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<DiscoverBloc>(context).add(const GetTopPosts());
    _scrollController.addListener(_listener);
    _scrollController.addListener(_loadMoreListener);

    super.initState();
  }

  void _listener() {
    scrollToRefreshListener(controller: _scrollController);
  }

  void _loadMoreListener() {
    scrollToRefreshListener(controller: _scrollController);
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent - 300) {
      if ((context.read<DiscoverBloc>().state is Loaded) &&
          ((context.read<DiscoverBloc>().state as Loaded).isLoading ||
              (context.read<DiscoverBloc>().state as Loaded).canLoadMore ==
                  false)) {
        return;
      }
      print('loading more');
      context.read<DiscoverBloc>().add(
            const LoadMore(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<DiscoverBloc>().add(
                      const ReloadPosts(),
                    );
              },
              child: Column(
                children: [
                  BlocBuilder<DiscoverBloc, DiscoverState>(
                    builder: (context, state) {
                      return state.maybeMap(loaded: (loaded) {
                        return SizedBox(
                          height: constraints.maxHeight,
                          child: ListView.builder(
                            itemCount: loaded.posts.length,
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: loaded.posts.length == index + 1
                                        ? 100
                                        : 0),
                                child: PersonalFeedPostContainer(
                                  post: loaded.posts[index],
                                  originScreen: ScreenPath.discoverScreen,
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
    _scrollController.removeListener(_loadMoreListener);
    _scrollController.dispose();
    super.dispose();
  }
}
