import 'package:flutter/material.dart';
import 'package:superkauf/generic/post/model/post_model.dart';

class SavePostButton extends StatefulWidget {
  final PostModel post;
  final bool isSaved;
  final Function(bool) onPressed;

  const SavePostButton({
    super.key,
    required this.post,
    required this.isSaved,
    required this.onPressed,
  });

  @override
  State<SavePostButton> createState() => _SavePostButtonState();
}

class _SavePostButtonState extends State<SavePostButton> {
  var isSaved = false;

  @override
  void initState() {
    isSaved = widget.isSaved;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          setState(() {
            isSaved = !isSaved;
          });
          widget.onPressed(isSaved);
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
