import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tvify/core/core.dart';
import 'package:tvify/core/utils/strings.dart';

class CachedImage extends StatelessWidget {
  const CachedImage(
    this.imageUrl, {
    super.key,
    this.fit = BoxFit.cover,
  });
  final String imageUrl;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final log = Logger('CachedImage');
    try {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Image.network(
          Strings.noImageAvailable,
          height: 25,
          width: 25,
          fit: BoxFit.cover,
        ),
      );
    } catch (e) {
      log.fine(e);
      return Image.network(
        Strings.noImageAvailable,
        height: 25,
        width: 25,
        fit: BoxFit.cover,
      );
    }
  }
}
