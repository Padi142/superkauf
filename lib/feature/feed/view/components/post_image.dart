import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:superkauf/generic/post/model/post_model.dart';

class FeedPostImage extends StatelessWidget {
  final BoxConstraints constraints;
  final PostModel post;
  const FeedPostImage({super.key, required this.constraints, required this.post});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: constraints.maxWidth,
      child: Hero(
        tag: post.id,
        child: CachedNetworkImage(
          imageUrl: post.image,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            )),
          ),
          cacheManager: CacheManager(
            Config(
              'post_image',
              stalePeriod: const Duration(days: 7),
            ),
          ),
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
