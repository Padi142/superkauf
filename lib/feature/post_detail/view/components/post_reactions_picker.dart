import 'package:flutter/material.dart';

class PostReactionsPickers extends StatefulWidget {
  final BoxConstraints constraints;
  const PostReactionsPickers({super.key, required this.constraints});

  @override
  State<PostReactionsPickers> createState() => _PostReactionsPickersState();
}

class _PostReactionsPickersState extends State<PostReactionsPickers> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            border: Border.all(
              color: Colors.purpleAccent,
              width: 1,
            ),
          ),
          child: SizedBox(
            width: widget.constraints.maxWidth * 0.2,
            height: 80,
            child: const Column(
              children: [
                Text(
                  'Likes',
                  style: TextStyle(
                    color: Colors.purpleAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black26,
              width: 1,
            ),
          ),
          child: SizedBox(
            width: widget.constraints.maxWidth * 0.2,
            height: 80,
            child: const Column(
              children: [
                Text(
                  'Saved',
                  style: TextStyle(
                    color: Colors.black26,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green,
              width: 1,
            ),
          ),
          child: SizedBox(
            width: widget.constraints.maxWidth * 0.2,
            height: 80,
            child: const Column(
              children: [
                Text(
                  'Bought',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            border: Border.all(
              color: Colors.redAccent,
              width: 1,
            ),
          ),
          child: SizedBox(
            width: widget.constraints.maxWidth * 0.2,
            height: 80,
            child: const Column(
              children: [
                Text(
                  'Report',
                  style: TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
