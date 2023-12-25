import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/feed/view/components/feed_post_container.dart';
import 'package:superkauf/feature/feed/view/components/loading_feed_post.dart';
import 'package:superkauf/feature/store_posts/bloc/store_posts_bloc.dart';
import 'package:superkauf/feature/store_posts/bloc/store_posts_state.dart';
import 'package:superkauf/feature/store_posts/view/components/store_headers.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/functions.dart';
import 'package:superkauf/generic/store/bloc/store_bloc.dart';
import 'package:superkauf/library/app.dart';

import '../../../library/app_screen.dart';

class StorePostsScreen extends Screen<int> {
  static const String name = ScreenPath.storesScreen;

  StorePostsScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<StorePostsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    if (widget.params != null) {
      _selectedStore = widget.params!;
    }

    context.read<StorePostsBloc>().add(GetPosts(storeId: _selectedStore));

    context.read<StoreBloc>().add(const GetAllStores());

    _scrollController.addListener(_listener);

    super.initState();
  }

  void _listener() {
    scrollToRefreshListener(controller: _scrollController);
  }

  var _selectedStore = 1;
  var _storesLength = 1;
  var isSwiping = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onHorizontalDragEnd: (end) {
          isSwiping = false;
        },
        onHorizontalDragUpdate: (details) {
          if (isSwiping || details.primaryDelta!.abs() < 10) {
            return;
          }
          isSwiping = true;
          if (details.primaryDelta! > 0) {
            print('swipe left');
            //Swipe left
            if (_selectedStore == 1) {
              return;
            }
            BlocProvider.of<StorePostsBloc>(context).add(
              GetPosts(storeId: _selectedStore - 1),
            );
            _selectedStore--;
          } else if (details.primaryDelta! < 0) {
            // Swiped right
            print('swipe right');
            if (_selectedStore >= _storesLength) {
              return;
            }
            BlocProvider.of<StorePostsBloc>(context).add(
              GetPosts(storeId: _selectedStore + 1),
            );
            _selectedStore++;
          }
        },
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<StorePostsBloc>().add(
                    GetPosts(storeId: _selectedStore),
                  );
            },
            child: BlocBuilder<StorePostsBloc, StorePostsState>(
              builder: (context, state) {
                return state.maybeMap(loaded: (loaded) {
                  if (loaded.posts.isEmpty) {
                    return Center(
                        child: Column(
                      children: [
                        Text(
                          'no_posts_for_store_1'.tr(),
                          style: App.appTheme.textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('no_posts_for_store_2'.tr(), style: App.appTheme.textTheme.titleSmall),
                      ],
                    ));
                  }
                  return Column(
                    children: [
                      StoreHeaders(
                        constraints: constraints,
                        onStoreSelected: (id) {
                          setState(() {
                            _selectedStore = id;
                          });
                          context.read<StorePostsBloc>().add(GetPosts(storeId: _selectedStore));
                        },
                        onStoresLoaded: (length) {
                          _storesLength = length;
                        },
                        selectedStore: _selectedStore,
                      ),
                      SizedBox(
                        height: constraints.maxHeight,
                        child: ListView.builder(
                          itemCount: loaded.posts.length,
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: loaded.posts.length == index + 1 ? 100 : 0),
                              child: FeedPostContainer(post: loaded.posts[index], originScreen: ScreenPath.storesScreen),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }, error: (error) {
                  return Center(child: Text(error.error));
                }, orElse: () {
                  return const PostLoadingView();
                });
              },
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }
}
