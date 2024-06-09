import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CdnImage extends StatelessWidget {
  final String url;
  final int width;
  final int height;
  final BoxConstraints constraints;
  const CdnImage(
      {super.key,
      required this.url,
      required this.constraints,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: getCdnUrl(),
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
    );
  }

  String getCdnUrl() {
    final parts = url.split('?');
    if (parts.length == 1) {
      return 'https://superkauf-images.netlify.app/.netlify/images?url=$url&w=$width&h=$height';
    }

    final parsedUrl = parts[0].replaceAll("%2F", "/").split('superkauf/o')[1];
    return 'https://superkauf-images.netlify.app/.netlify/images?url=https://storage.googleapis.com/superkauf$parsedUrl&w=$width&h=$height';

    // return 'https://superkauf-images.netlify.app/.netlify/images?url=${url.split('?')[0]}&w=$width&h=$height';
  }
}
