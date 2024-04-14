import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

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
        child: CachedNetworkImage(
          imageUrl: postImage,
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
          progressIndicatorBuilder: (context, url, downloadProgress) => CardLoading(
            height: constraints.maxHeight,
            cardLoadingTheme: CardLoadingTheme(
              colorOne: Theme.of(context).colorScheme.secondary,
              colorTwo: Theme.of(context).colorScheme.primary,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
