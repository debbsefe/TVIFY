import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage(
    this.imageUrl, {
    Key? key,
    this.isRound = false,
    this.radius = 0,
    this.height,
    this.width,
    this.fit = BoxFit.fill,
  }) : super(key: key);
  final String imageUrl;
  final bool isRound;
  final double radius;
  final double? height;
  final double? width;

  final BoxFit fit;

  final String noImageAvailable =
      'https://www.esm.rochester.edu/uploads/NoPhotoAvailable.jpg';

  @override
  Widget build(BuildContext context) {
    try {
      return SizedBox(
        height: isRound ? radius : height,
        width: isRound ? radius : width,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(isRound ? 50 : radius),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: fit,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Image.network(
                noImageAvailable,
                height: 25,
                width: 25,
                fit: BoxFit.cover,
              ),
            )),
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return Image.network(
        noImageAvailable,
        height: 25,
        width: 25,
        fit: BoxFit.cover,
      );
    }
  }
}
