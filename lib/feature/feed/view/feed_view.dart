import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/feed/bloc/feed_bloc.dart';
import 'package:superkauf/feature/feed/bloc/feed_state.dart';
import 'package:superkauf/feature/feed/view/components/feed_post_container.dart';
import 'package:superkauf/feature/feed/view/components/loading_feed_post.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/functions.dart';

import '../../../library/app_screen.dart';

class FeedScreen extends Screen {
  static const String name = ScreenPath.feedScreen;

  FeedScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<FeedBloc>(context).add(const GetFeed());
    _scrollController.addListener(_listener);
    _scrollController.addListener(_loadMoreListener);
    super.initState();
  }

  void _listener() {
    scrollToRefreshListener(controller: _scrollController);
  }

  void _loadMoreListener() {
    scrollToRefreshListener(controller: _scrollController);
    if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 300) {
      if ((context.read<FeedBloc>().state is Loaded) && ((context.read<FeedBloc>().state as Loaded).isLoading || (context.read<FeedBloc>().state as Loaded).canLoadMore == false)) {
        return;
      }
      print('loading more');
      context.read<FeedBloc>().add(
            const LoadMore(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<FeedBloc>().add(
                  const ReloadFeed(),
                );
          },
          child: Column(
            children: [
              BlocBuilder<FeedBloc, FeedState>(
                builder: (context, state) {
                  return state.maybeMap(loaded: (loaded) {
                    return SizedBox(
                      height: constraints.maxHeight,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: loaded.isLoading ? loaded.posts.length + 1 : loaded.posts.length,
                        cacheExtent: 800,
                        itemBuilder: (context, index) {
                          // If loading , show loading indicator

                          if (index == loaded.posts.length) {
                            return const PostLoadingView();
                          }

                          // If not loading , show posts
                          return PersonalFeedPostContainer(
                            post: loaded.posts[index],
                            originScreen: ScreenPath.feedScreen,
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
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.removeListener(_loadMoreListener);
    _scrollController.dispose();
    super.dispose();
  }
}
