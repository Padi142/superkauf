import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:superkauf/feature/shopping_list/bloc/shopping_list_bloc.dart';
import 'package:superkauf/feature/shopping_list/bloc/shopping_list_state.dart';
import 'package:superkauf/feature/shopping_list/view/components/loading_view.dart';
import 'package:superkauf/feature/shopping_list/view/components/shopping_list_tile.dart';
import 'package:superkauf/feature/shopping_list/view/components/shopping_list_view.dart';
import 'package:superkauf/feature/shopping_list/view/components/store_posts_view.dart';
import 'package:superkauf/feature/snackbar/bloc/snackbar_bloc.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/functions.dart';
import 'package:superkauf/generic/shopping_list/bloc/shopping_list_data_bloc.dart';
import 'package:superkauf/generic/shopping_list/bloc/shopping_list_data_state.dart';
import 'package:superkauf/generic/widget/app_button.dart';
import 'package:superkauf/generic/widget/app_text_field/index.dart';
import 'package:superkauf/library/app.dart';

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
    BlocProvider.of<ShoppingListBloc>(context).add(const InitialListEvent());
    _scrollController.addListener(_listener);
    _scrollController.addListener(_loadMoreListener);
    super.initState();
  }

  void _listener() {
    scrollToRefreshListener(controller: _scrollController);
  }

  void _loadMoreListener() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<ShoppingListDataBloc, ShoppingListDataState>(
        listener: (context, state) {
          state.maybeMap(
              orElse: () {},
              listJoined: (list) {
                context.read<ShoppingListBloc>().add(PickShoppingList(
                      shoppingListId: list.listId,
                    ));
              },
              listDeleted: (list) {
                context.read<ShoppingListBloc>().add(const InitialListEvent());
              },
              listLeaved: (leaved) {
                context.read<ShoppingListBloc>().add(const InitialListEvent());
              },
              error: (error) {
                BlocProvider.of<SnackbarBloc>(context).add(ErrorSnackbar(
                  message: error.message,
                ));
              });
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            elevation: 4,
            onPressed: () {
              _showPopup(
                context,
                (code) {
                  context.read<ShoppingListDataBloc>().add(JoinList(code: code));

                  Posthog().capture(
                    eventName: 'shopping_list_joined',
                    properties: {
                      'code': code,
                    },
                  );
                },
                (name) {
                  context.read<ShoppingListDataBloc>().add(CreateList(name: name));
                  Posthog().capture(
                    eventName: 'shopping_list_created',
                    properties: {
                      'name': name,
                    },
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
          body: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<ShoppingListBloc>().add(
                        const ReloadShoppingList(),
                      );
                },
                child: Column(
                  children: [
                    BlocBuilder<ShoppingListBloc, ShoppingListState>(builder: (context, state) {
                      return _builder(context, state, constraints);
                    }),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _builder(BuildContext context, ShoppingListState state, BoxConstraints constraints) {
    return state.maybeMap(initial: (initial) {
      return SizedBox(
        key: UniqueKey(),
        height: constraints.maxHeight,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: initial.shoppingLists.length + initial.stores.length + 1,
          itemBuilder: (context, index) {
            if (index == initial.shoppingLists.length) {
              return const Divider();
            }
            var posts = 0;
            if (index > initial.shoppingLists.length) {
              posts = initial.savedPosts.where((element) => element.post.store == initial.stores[index - (initial.shoppingLists.length + 1)].id).length;
              if (posts == 0) {
                return const SizedBox();
              }
            }

            return ShoppingListTile(
              key: UniqueKey(),
              image: index < initial.shoppingLists.length ? initial.shoppingLists[index].logo : initial.stores[index - (initial.shoppingLists.length + 1)].image,
              name: index < initial.shoppingLists.length ? initial.shoppingLists[index].name : initial.stores[index - (initial.shoppingLists.length + 1)].name,
              items: (index < initial.shoppingLists.length ? initial.shoppingLists[index].postsLength : posts) ?? 0,
              constraints: constraints,
              onTap: () {
                index < initial.shoppingLists.length
                    ? context.read<ShoppingListBloc>().add(PickShoppingList(shoppingListId: initial.shoppingLists[index].id))
                    : context.read<ShoppingListBloc>().add(PickStore(store: initial.stores[index - (initial.shoppingLists.length + 1)]));

                Posthog().capture(eventName: index < initial.shoppingLists.length ? 'shopping_list_tile_tapped' : 'store_tile_tapped', properties: {
                  'list': index < initial.shoppingLists.length ? initial.shoppingLists[index].id : initial.stores[index - (initial.shoppingLists.length + 1)].id,
                });
              },
            );
          },
        ),
      );
    }, showStore: (store) {
      return SizedBox(
        key: UniqueKey(),
        height: constraints.maxHeight,
        child: StoresPostsListView(
          posts: store.posts,
          store: store.store,
          constraints: constraints,
          scrollController: _scrollController,
        ),
      );
    }, showShoppingList: (showShoppingList) {
      return SizedBox(
        key: UniqueKey(),
        height: constraints.maxHeight,
        child: ShoppingListView(
          list: showShoppingList.list,
          constraints: constraints,
          userId: showShoppingList.userId,
        ),
      );
    }, error: (error) {
      return Center(child: Text(error.error));
    }, orElse: () {
      return SizedBox(
        width: constraints.maxWidth,
        child: ShoppingListLoadingView(
          constraints: constraints,
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

  Future<void> _showPopup(BuildContext context, Function(String) onJoin, Function(String) onCreate) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ListDialog(
          originalContext: context,
          onJoin: onJoin,
          onCreate: onCreate,
        );
      },
    );
  }
}

class ListDialog extends StatefulWidget {
  final BuildContext originalContext;
  final Function(String) onJoin;
  final Function(String) onCreate;
  const ListDialog({
    super.key,
    required this.originalContext,
    required this.onJoin,
    required this.onCreate,
  });

  @override
  State<ListDialog> createState() => _ListDialogState();
}

class _ListDialogState extends State<ListDialog> {
  var showCreate = false;
  var showJoin = false;

  final inputField = TextEntryModel();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 200,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: !showJoin && !showCreate
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      backgroundColor: App.appTheme.colorScheme.primary,
                      radius: 6,
                      text: 'Join a list',
                      textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                      elevation: 4,
                      onClick: () {
                        setState(() {
                          showJoin = true;
                        });
                      },
                    ),
                    const Gap(8),
                    AppButton(
                      backgroundColor: App.appTheme.colorScheme.primary,
                      radius: 6,
                      text: 'Create a list',
                      textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                      elevation: 4,
                      onClick: () {
                        setState(() {
                          showCreate = true;
                        });
                      },
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextField(
                      inputField,
                      context: context,
                      label: showCreate ? 'My List :PP ' : 'Join code',
                      validators: [
                        ValidatorEmpty(),
                        ValidatorRegex(r'^.{3,20}$', 'Invalid input. 3-20 characters only'),
                      ],
                    ),
                    const Gap(8),
                    AppButton(
                      backgroundColor: App.appTheme.colorScheme.primary,
                      radius: 6,
                      text: showCreate ? 'Create' : 'Join',
                      textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                      elevation: 4,
                      onClick: () async {
                        final valid = await TextEntryModel.validateFields([inputField]);

                        if (!valid) {
                          setState(() {});
                          return;
                        }

                        if (showCreate) {
                          widget.onCreate(inputField.text);
                          Navigator.of(context).pop();
                        } else {
                          widget.onJoin(inputField.text);
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
