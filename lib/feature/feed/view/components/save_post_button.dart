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

var postSaved = false;

class _SavePostButtonState extends State<SavePostButton> {
  @override
  void initState() {
    if (widget.originScreen == ScreenPath.shoppingListScreen) {
      postSaved = true;
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
            icon: Icon(
              postSaved ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.black,
            ),
            onPressed: () {
              if (!postSaved) {
                BlocProvider.of<PostBloc>(context).add(
                  SavePost(
                    postId: widget.postId,
                  ),
                );
              } else {
                BlocProvider.of<PostBloc>(context).add(
                  RemoveSavedPost(
                    postId: widget.postId,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
