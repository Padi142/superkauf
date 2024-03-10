import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_bloc.dart';
import 'package:superkauf/feature/shopping_list/bloc/shopping_list_bloc.dart';
import 'package:superkauf/feature/shopping_list/view/components/list_action_buttons.dart';
import 'package:superkauf/generic/post/bloc/post_bloc.dart';
import 'package:superkauf/generic/shopping_list/model/get_shopping_list_response.dart';
import 'package:superkauf/generic/user/model/user_model.dart';
import 'package:superkauf/generic/widget/app_progress.dart';
import 'package:superkauf/library/app.dart';

class ShoppingListView extends StatefulWidget {
  final GetShoppingListResponse list;
  final BoxConstraints constraints;

  final int userId;

  const ShoppingListView({
    super.key,
    required this.list,
    required this.constraints,
    required this.userId,
  });

  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: widget.constraints.maxWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: widget.constraints.maxWidth * 0.1,
                child: IconButton(
                    onPressed: () {
                      BlocProvider.of<ShoppingListBloc>(context).add(const InitialListEvent());
                    },
                    icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Material(
                  elevation: 4, // Adjust the elevation as needed
                  borderRadius: BorderRadius.circular(6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    // Adjust the radius as needed
                    child: CachedNetworkImage(
                      height: 50,
                      width: widget.constraints.maxWidth * 0.25,
                      imageUrl: widget.list.list.logo,
                      fit: BoxFit.fitWidth,
                      placeholder: (context, url) => const Center(child: AppProgress()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              const Gap(2),
              SizedBox(width: widget.constraints.maxWidth * 0.45, child: Text(widget.list.list.name, maxLines: 4, style: App.appTheme.textTheme.titleMedium)),
              ListActionButtons(
                list: widget.list.list,
                canEdit: widget.list.list.createdBy == widget.userId,
              ),
            ],
          ),
        ),
        const Gap(8),
        SizedBox(
          height: widget.constraints.maxHeight * 0.8,
          child: ListView.builder(
            itemCount: widget.list.posts.length,
            itemBuilder: (context, index) {
              return ShoppingListItem(
                post: widget.list.posts[index].post,
                addedBy: widget.list.posts[index].addedBy,
                listId: widget.list.list.id,
                onToggleCompleted: (completed) {
                  context.read<ShoppingListBloc>().add(
                        UpdateSavedPostEvent(
                          postId: widget.list.posts[index].post.savedPost.id,
                          isCompleted: completed,
                        ),
                      );
                },
                completed: widget.list.posts[index].post.savedPost.isCompleted,
              );
            },
          ),
        ),
      ],
    );
  }
}

class ShoppingListItem extends StatefulWidget {
  final SavedPostWithContext post;
  final UserModel addedBy;
  final int listId;
  final bool completed;
  final ValueChanged<bool> onToggleCompleted;

  const ShoppingListItem({
    super.key,
    required this.post,
    required this.addedBy,
    required this.listId,
    this.completed = false,
    required this.onToggleCompleted,
  });

  @override
  State<ShoppingListItem> createState() => _ShoppingListItemState();
}

class _ShoppingListItemState extends State<ShoppingListItem> {
  var isCompleted = false;

  @override
  void initState() {
    isCompleted = widget.completed;
    super.initState();
  }

  final GlobalKey _widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: ListTile(
        key: _widgetKey,
        subtitle: Text('${widget.post.post.price}Kč'),
        leading: Padding(
          padding: const EdgeInsets.all(1),
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<PostDetailBloc>(context).add(InitialEvent(
                post: widget.post.post,
                user: null,
              ));

              BlocProvider.of<NavigationBloc>(context).add(OpenPostDetailScreen(
                postId: widget.post.post.id,
              ));
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      // Adjust the radius as needed
                      child: CachedNetworkImage(
                        imageUrl: widget.post.post.image,
                        fit: BoxFit.fitWidth,
                        color: isCompleted ? Colors.grey : null,
                        colorBlendMode: isCompleted ? BlendMode.saturation : null,
                        placeholder: (context, url) => const Center(child: AppProgress()),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Material(
                    elevation: 4, // Adjust the elevation as needed
                    borderRadius: BorderRadius.circular(40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      // Adjust the radius as needed
                      child: CachedNetworkImage(
                        height: 20,
                        width: 20,
                        imageUrl: widget.addedBy.profilePicture,
                        fit: BoxFit.fitWidth,
                        placeholder: (context, url) => const Center(child: AppProgress()),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        title: Text(
          widget.post.post.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
            color: isCompleted ? Colors.grey : Colors.black,
          ),
        ),
        trailing: Checkbox(
          value: isCompleted,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          onChanged: (value) {
            widget.onToggleCompleted(value!);

            setState(() {
              isCompleted = value;
            });
          },
        ),
        onTap: () {},
        onLongPress: () {
          final RenderBox renderBox = _widgetKey.currentContext!.findRenderObject() as RenderBox;
          showMenu(
            context: context,
            position: RelativeRect.fromRect(
              Rect.fromPoints(
                renderBox.localToGlobal(Offset.zero),
                renderBox.localToGlobal(renderBox.size.bottomRight(Offset.zero)),
              ),
              Offset.zero & MediaQuery.of(context).size,
            ),
            items: <PopupMenuEntry>[
              PopupMenuItem<String>(
                  value: 'delete',
                  child: const Text('Delete post'),
                  onTap: () {
                    BlocProvider.of<PostBloc>(context).add(RemoveSavedPost(postId: widget.post.post.id));

                    BlocProvider.of<ShoppingListBloc>(context).add(PickShoppingList(shoppingListId: widget.listId));
                  }),
            ],
          );
        },
      ),
    );
  }
}
