import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/feed/view/components/feed_post_container.dart';
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
    BlocProvider.of<ShoppingListBloc>(context).add(const GetShoppingList());
    _scrollController.addListener(_listener);
    super.initState();
  }

  void _listener() {
    scrollToRefreshListener(controller: _scrollController);
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
                  return state.maybeMap(loaded: (loaded) {
                    return SizedBox(
                      height: constraints.maxHeight,
                      child: ListView.builder(
                        itemCount: loaded.posts.length,
                        itemBuilder: (context, index) {
                          return FeedPostContainer(
                            post: loaded.posts[index],
                            originScreen: ScreenPath.shoppingListScreen,
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
    _scrollController.dispose();
    super.dispose();
  }
}
