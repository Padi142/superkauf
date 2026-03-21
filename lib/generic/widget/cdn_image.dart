import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

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
      imageUrl: getDisplayUrl(),
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        )),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => CardLoading(
        height: constraints.maxHeight,
        cardLoadingTheme: CardLoadingTheme(
          colorOne: Theme.of(context).colorScheme.secondary,
          colorTwo: Theme.of(context).colorScheme.primary,
        ),
      ),
      errorWidget: (context, url, error) => ColoredBox(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: const Center(
          child: Icon(Icons.broken_image_outlined),
        ),
      ),
    );
  }

  String getDisplayUrl() {
    if (_isLegacyGoogleStorageUrl || _isLegacySupabaseStorageUrl) {
      return _getProxyUrl();
    }

    return url;
  }

  bool get _isLegacyGoogleStorageUrl =>
      url.contains('storage.googleapis.com/superkauf');

  bool get _isLegacySupabaseStorageUrl => url.contains('supabase.co/storage/');

  String _getProxyUrl() {
    final encodedUrl = Uri.encodeComponent(url);
    return 'https://superkauf-images.netlify.app/.netlify/images?url=$encodedUrl&w=$width&h=$height';
  }
}
