import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/feed/view/components/loading_feed_post.dart';
import 'package:superkauf/feature/shopping_list/bloc/shopping_list_bloc.dart';
import 'package:superkauf/feature/shopping_list/bloc/shopping_list_state.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/functions.dart';

import '../../../library/app_screen.dart';

class ShoppingListScreen extends Screen {
  static const String name = ScreenPath.shoppingListScreen;

  ShoppingListScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<ShoppingListBloc>(context).add(const InitialEvent());
    _scrollController.addListener(_listener);
    _scrollController.addListener(_loadMoreListener);
    super.initState();
  }

  void _listener() {
    scrollToRefreshListener(controller: _scrollController);
  }

  void _loadMoreListener() {
    // scrollToRefreshListener(controller: _scrollController);
    // if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 300) {
    //   if ((context.read<ShoppingListBloc>().state is Loaded) &&
    //       ((context.read<ShoppingListBloc>().state as Loaded).isLoading || (context.read<ShoppingListBloc>().state as Loaded).canLoadMore == false)) {
    //     return;
    //   }
    //   print('loading more');
    //   context.read<ShoppingListBloc>().add(
    //         const LoadMore(),
    //       );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<ShoppingListBloc>().add(
                  const ReloadShoppingList(),
                );
          },
          child: Column(
            children: [
              BlocBuilder<ShoppingListBloc, ShoppingListState>(
                builder: (context, state) {
                  return state.maybeMap(initial: (initial) {
                    return Column(
                      children: [
                        SizedBox(
                          height: constraints.maxHeight * 0.49,
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: initial.shoppingLists.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  // Adjust the radius as needed
                                  child: CachedNetworkImage(
                                    imageUrl: initial.shoppingLists[index].logo,
                                    fit: BoxFit.fitWidth,
                                    placeholder: (context, url) => const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                                title: Text(initial.shoppingLists[index].name),
                                onTap: () {},
                              );
                            },
                          ),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.49,
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: initial.stores.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  // Adjust the radius as needed
                                  child: CachedNetworkImage(
                                    imageUrl: initial.stores[index].image,
                                    fit: BoxFit.fitWidth,
                                    placeholder: (context, url) => const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                                title: Text(initial.stores[index].name),
                                onTap: () {},
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
