import 'package:flutter/material.dart';

class PostActionBar extends StatefulWidget {
  const PostActionBar({super.key});

  @override
  State<PostActionBar> createState() => _PostActionBarState();
}

class _PostActionBarState extends State<PostActionBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite,
              size: 35,
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.bookmark_border,
                color: Colors.black,
                size: 35,
              )),
        ],
      ),
    );
  }
}
