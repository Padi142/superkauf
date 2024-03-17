import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_bloc.dart';
import 'package:superkauf/feature/user_detail/bloc/user_detail_bloc.dart';
import 'package:superkauf/feature/user_detail/bloc/user_detail_state.dart';
import 'package:superkauf/feature/user_detail/view/componenets/user_detail_view_preview.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/functions.dart';
import 'package:superkauf/generic/widget/app_progress.dart';

import '../../../library/app_screen.dart';
import 'componenets/user_detail_view.dart';

class UserDetailScreen extends Screen {
  static const String name = ScreenPath.userDetailScreen;

  UserDetailScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_loadMoreListener);
    _scrollController.addListener(_listener);

    super.initState();
  }

  void _listener() {
    scrollToRefreshListener(controller: _scrollController);
  }

  void _loadMoreListener() {
    scrollToRefreshListener(controller: _scrollController);
    if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 300) {
      if ((context.read<UserDetailBloc>().state is Loaded) && ((context.read<UserDetailBloc>().state as Loaded).isLoading || (context.read<UserDetailBloc>().state as Loaded).canLoadMore == false)) {
        return;
      }
      print('loading more');
      context.read<UserDetailBloc>().add(
            const LoadMore(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        return BlocBuilder<UserDetailBloc, UserDetailState>(
          builder: (context, state) {
            return state.maybeMap(initial: (initial) {
              return SizedBox(
                  width: constraints.maxWidth,
                  child: Column(
                    children: [
                      UserDetailViewPreview(
                        user: initial.user,
                        constraints: constraints,
                      ),
                      const AppProgress()
                    ],
                  ));
            }, loaded: (loaded) {
              return SizedBox(
                  width: constraints.maxWidth,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<UserDetailBloc>().add(
                            const ReloadUser(),
                          );
                    },
                    child: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverToBoxAdapter(
                          child: UserDetailView(
                            user: loaded.user,
                            constraints: constraints,
                          ),
                        ),
                        SliverGrid.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                          ),
                          itemCount: loaded.posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Hero(
                              tag: loaded.posts[index].post.id,
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<PostDetailBloc>(context).add(InitialEvent(
                                    post: loaded.posts[index].post,
                                    user: loaded.posts[index].user,
                                  ));

                                  BlocProvider.of<NavigationBloc>(context).add(OpenPostDetailScreen(
                                    postId: loaded.posts[index].post.id,
                                  ));
                                },
                                child: CachedNetworkImage(
                                  imageUrl: loaded.posts[index].post.image,
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    )),
                                  ),
                                  cacheManager: CacheManager(
                                    Config(
                                      'post_image',
                                      stalePeriod: const Duration(days: 7),
                                    ),
                                  ),
                                  progressIndicatorBuilder: (context, url, downloadProgress) => CardLoading(height: constraints.maxWidth * 0.3),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ));
            }, error: (error) {
              return Text(error.error);
            }, orElse: () {
              return const Center(child: AppProgress());
            });
          },
        );
      }),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }
}
