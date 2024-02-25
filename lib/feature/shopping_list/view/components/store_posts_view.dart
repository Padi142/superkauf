import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_bloc.dart';
import 'package:superkauf/feature/shopping_list/bloc/shopping_list_bloc.dart';
import 'package:superkauf/generic/post/bloc/post_bloc.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';
import 'package:superkauf/generic/store/model/store_model.dart';
import 'package:superkauf/generic/widget/app_progress.dart';
import 'package:superkauf/library/app.dart';

class StoresPostsListView extends StatefulWidget {
  final List<FullContextPostModel> posts;
  final StoreModel store;
  final BoxConstraints constraints;
  final ScrollController scrollController;

  const StoresPostsListView({
    super.key,
    required this.posts,
    required this.store,
    required this.constraints,
    required this.scrollController,
  });

  @override
  State<StoresPostsListView> createState() => _StoresPostsListViewState();
}

class _StoresPostsListViewState extends State<StoresPostsListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: widget.constraints.maxWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    BlocProvider.of<ShoppingListBloc>(context).add(const InitialListEvent());
                  },
                  icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 4, // Adjust the elevation as needed
                  borderRadius: BorderRadius.circular(6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    // Adjust the radius as needed
                    child: CachedNetworkImage(
                      height: 60,
                      width: 120,
                      imageUrl: widget.store.image,
                      fit: BoxFit.fitWidth,
                      placeholder: (context, url) => const Center(child: AppProgress()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              const Gap(4),
              Text(widget.store.name, style: App.appTheme.textTheme.titleMedium),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
        SizedBox(
          height: widget.constraints.maxHeight * 0.8,
          child: ListView.builder(
            itemCount: widget.posts.length,
            itemBuilder: (context, index) {
              return StoreListItem(
                  post: widget.posts[index],
                  store: widget.store,
                  onToggleCompleted: (completed) {
                    context.read<ShoppingListBloc>().add(
                          UpdateSavedPostEvent(
                            postId: widget.posts[index].saved?.id ?? widget.posts[index].post.id,
                            isCompleted: completed,
                          ),
                        );
                  },
                  completed: widget.posts[index].saved?.isCompleted ?? false);
            },
          ),
        ),
      ],
    );
  }
}

class StoreListItem extends StatefulWidget {
  final FullContextPostModel post;
  final bool completed;
  final StoreModel store;
  final ValueChanged<bool> onToggleCompleted;

  const StoreListItem({
    Key? key,
    required this.post,
    this.completed = false,
    required this.store,
    required this.onToggleCompleted,
  }) : super(key: key);

  @override
  State<StoreListItem> createState() => _StoreListItemState();
}

class _StoreListItemState extends State<StoreListItem> {
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
          padding: const EdgeInsets.all(2),
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<PostDetailBloc>(context).add(InitialEvent(
                post: widget.post.post,
                user: widget.post.user,
              ));

              BlocProvider.of<NavigationBloc>(context).add(const OpenPostDetailScreen());
            },
            child: Material(
              elevation: 4, // Adjust the elevation as needed
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

                    BlocProvider.of<ShoppingListBloc>(context).add(PickStore(store: widget.store));
                  }),
            ],
          );
        },
      ),
    );
  }
}
