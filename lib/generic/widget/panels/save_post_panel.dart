import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:superkauf/feature/home/bloc/saved_posts_panel_bloc/saved_posts_panel_bloc.dart';
import 'package:superkauf/feature/home/bloc/saved_posts_panel_bloc/saved_posts_panel_state.dart';
import 'package:superkauf/generic/shopping_list/bloc/shopping_list_data_bloc.dart';
import 'package:superkauf/generic/widget/panels/tiles/saved_post_list_tile.dart';
import 'package:superkauf/library/app.dart';

class SavePostPanel extends StatelessWidget {
  final PanelController panelController;

  const SavePostPanel({
    super.key,
    required this.panelController,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LayoutBuilder(builder: (context, constrains) {
        return BlocBuilder<SavedPostsPanelBloc, SavedPostsPanelState>(builder: (context, state) {
          return state.maybeMap(
            orElse: () => Center(
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: CardLoading(
                          width: constrains.maxWidth * 0.7,
                          height: 60,
                        ),
                      )),
            ),
            loaded: (loaded) {
              return Column(
                children: [
                  const Gap(
                    25,
                  ),
                  Text('Save a post!', style: App.appTheme.textTheme.titleMedium),
                  const Gap(20),
                  SizedBox(
                    height: constrains.maxHeight - 70,
                    child: ListView.builder(
                      itemCount: loaded.lists.length + 1,
                      itemBuilder: (context, index) {
                        if (index == loaded.lists.length) {
                          return Column(
                            children: [
                              const Gap(10),
                              StoreSavedPostTile(store: loaded.store),
                            ],
                          );
                        }
                        return SavedPostListTile(
                          list: loaded.lists[index],
                          postId: loaded.postId,
                          isSaved: false,
                          onTap: (isClicked) {
                            if (isClicked) {
                              BlocProvider.of<ShoppingListDataBloc>(context).add(
                                AddPostToList(
                                  postId: loaded.postId,
                                  listId: loaded.lists[index].id,
                                ),
                              );
                            } else {
                              BlocProvider.of<ShoppingListDataBloc>(context).add(
                                RemovePostFromList(
                                  postId: loaded.postId,
                                  listId: loaded.lists[index].id,
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        });
      }),
    );
  }
}
