import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/model/photo_model.dart';
import 'shimmer_placeholder.dart';

class PhotoGridViewItem extends StatelessWidget {
  const PhotoGridViewItem({
    super.key,
    required this.photos,
    required this.index,
  });

  final List<PhotoModel> photos;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: (index % 3 + 1) * 100.0,
        child: CachedNetworkImage(
          key: ValueKey(photos[index].id),
          imageUrl: photos[index].src.medium,
          fit: BoxFit.cover,
          placeholder:
              (context, url) => Center(child: ShimmerPlaceholder(index)),
          errorWidget:
              (context, url, error) =>
                  const Icon(Icons.error, color: Colors.red),
        ),
      ),
    );
  }
}
