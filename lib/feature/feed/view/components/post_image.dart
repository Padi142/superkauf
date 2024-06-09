import 'package:flutter/material.dart';
import 'package:superkauf/generic/widget/cdn_image.dart';

class FeedPostImage extends StatelessWidget {
  final BoxConstraints constraints;
  final String postImage;
  final int id;

  const FeedPostImage({
    super.key,
    required this.constraints,
    required this.postImage,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: constraints.maxWidth,
      child: Hero(
          tag: id,
          child: CdnImage(
            url: postImage,
            constraints: constraints,
            width: 850,
            height: 850,
          )),
    );
  }
}
