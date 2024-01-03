import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/post/bloc/post_bloc.dart';

class SavePostButton extends StatelessWidget {
  final int postId;
  final String originScreen;
  final bool isSaved;
  final Function(bool) onPressed;

  const SavePostButton({
    super.key,
    required this.postId,
    required this.originScreen,
    required this.isSaved,
    required this.onPressed,
  });

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
            icon: Icon(
              originScreen == ScreenPath.shoppingListScreen || isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.black,
            ),
            onPressed: () {
              if (originScreen == ScreenPath.shoppingListScreen || isSaved) {
                BlocProvider.of<PostBloc>(context).add(
                  RemoveSavedPost(
                    postId: postId,
                  ),
                );
                onPressed(false);
              } else {
                BlocProvider.of<PostBloc>(context).add(
                  SavePost(
                    postId: postId,
                  ),
                );
                onPressed(true);
              }
            },
          ),
        ),
      ),
    );
  }
}
