import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_bloc.dart';
import 'package:superkauf/feature/shopping_list/bloc/shopping_list_bloc.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';

class ShoppingListView extends StatefulWidget {
  final List<FullContextPostModel> posts;
  final ScrollController scrollController;

  const ShoppingListView({
    super.key,
    required this.posts,
    required this.scrollController,
  });

  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.posts.length,
      itemBuilder: (context, index) {
        return ShoppingListItem(
            post: widget.posts[index],
            onToggleCompleted: (completed) {
              context.read<ShoppingListBloc>().add(
                    UpdateSavedPostEvent(
                      postId: widget.posts[index].saved?.id ??
                          widget.posts[index].post.id,
                      isCompleted: completed,
                    ),
                  );
            },
            completed: widget.posts[index].saved?.isCompleted ?? false);
      },
    );
  }
}

class ShoppingListItem extends StatefulWidget {
  final FullContextPostModel post;
  final bool completed;
  final ValueChanged<bool> onToggleCompleted;

  const ShoppingListItem({
    Key? key,
    required this.post,
    this.completed = false,
    required this.onToggleCompleted,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: ListTile(
        subtitle: Text('${widget.post.post.price}Kč'),
        leading: Padding(
          padding: const EdgeInsets.all(2),
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<PostDetailBloc>(context).add(InitialEvent(
                post: widget.post.post,
                user: widget.post.user,
              ));

              BlocProvider.of<NavigationBloc>(context)
                  .add(const OpenPostDetailScreen());
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              // Adjust the radius as needed
              child: CachedNetworkImage(
                imageUrl: widget.post.post.image,
                fit: BoxFit.fitWidth,
                color: isCompleted ? Colors.grey : null,
                colorBlendMode: isCompleted ? BlendMode.saturation : null,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        title: Text(
          widget.post.post.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            decoration:
                isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
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
      ),
    );
  }
}
