import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hot_movies/style/style.dart';

class HeadshotImage extends StatelessWidget {
  const HeadshotImage({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 1.8,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              AppSpacing.borderRadius,
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: imageUrl!,
            fit: BoxFit.fitHeight,
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
