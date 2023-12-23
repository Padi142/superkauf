import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/post/bloc/post_bloc.dart';

class SavePostButton extends StatefulWidget {
  final int postId;
  final String originScreen;
  const SavePostButton({
    super.key,
    required this.postId,
    required this.originScreen,
  });

  @override
  State<SavePostButton> createState() => _SavePostButtonState();
}

var _iconFilled = false;

class _SavePostButtonState extends State<SavePostButton> {
  @override
  void initState() {
    if (widget.originScreen == ScreenPath.shoppingListScreen) {
      _iconFilled = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: IconButton(
            iconSize: 30,
            key: ValueKey<bool>(_iconFilled),
            icon: Icon(
              _iconFilled ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _iconFilled = !_iconFilled;
              });
              if (_iconFilled) {
                BlocProvider.of<PostBloc>(context).add(
                  SavePost(
                    postId: widget.postId,
                  ),
                );
                return;
              }

              BlocProvider.of<PostBloc>(context).add(
                RemoveSavedPost(
                  postId: widget.postId,
                ),
              );
              // switch (widget.originScreen) {
              //   case ScreenPath.shoppingListScreen:
              //     BlocProvider.of<ShoppingListBloc>(context).add(
              //       const ReloadShoppingList(),
              //     );
              //     break;
              //   case ScreenPath.feedScreen:
              //     BlocProvider.of<FeedBloc>(context).add(
              //       const ReloadFeed(),
              //     );
              //     break;
              //   case ScreenPath.storesScreen:
              //     BlocProvider.of<StorePostsBloc>(context).add(
              //       const ReloadStorePosts(),
              //     );
              //   default:
              //     break;
              // }
            },
          ),
        ),
      ),
    );
  }
}
