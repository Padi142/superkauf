import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/feed/view/components/loading_feed_post.dart';
import 'package:superkauf/feature/shopping_list/bloc/shopping_list_bloc.dart';
import 'package:superkauf/feature/shopping_list/bloc/shopping_list_state.dart';
import 'package:superkauf/feature/shopping_list/view/components/shopping_list_view.dart';
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
  final PageController controller = PageController();
  var selectedStore = 0;

  @override
  void initState() {
    BlocProvider.of<ShoppingListBloc>(context).add(const GetShoppingList());
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
      if ((context.read<ShoppingListBloc>().state is Loaded) &&
          ((context.read<ShoppingListBloc>().state as Loaded).isLoading || (context.read<ShoppingListBloc>().state as Loaded).canLoadMore == false)) {
        return;
      }
      print('loading more');
      context.read<ShoppingListBloc>().add(
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
            context.read<ShoppingListBloc>().add(
                  const ReloadShoppingList(),
                );
          },
          child: BlocBuilder<ShoppingListBloc, ShoppingListState>(
            builder: (context, state) {
              return state.maybeMap(loaded: (loaded) {
                final stores = loaded.posts.map((post) => post.post.store).toSet().toList();
                return Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: constraints.maxWidth,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: stores.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedStore = index;
                                  });
                                  controller.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.bounceIn);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedStore == index ? Colors.black : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 4),
                                          blurRadius: 4,
                                          color: Colors.black.withOpacity(0.25),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(loaded.stores.firstWhere((element) => element.id == stores[index]).name,
                                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                color: selectedStore == index ? Colors.white : Colors.black,
                                              )),
                                    )),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.9,
                      child: PageView(
                          controller: controller,
                          onPageChanged: (index) {
                            setState(() {
                              selectedStore = index;
                            });
                          },
                          children: stores
                              .map((store) => ShoppingListView(
                                    posts: loaded.posts.where((post) => post.post.store == store).toList(),
                                    scrollController: _scrollController,
                                  ))
                              .toList()),
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
