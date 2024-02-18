import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:search_image/domain/entity/image_info_entitiy.dart';

class ImageListItem extends StatelessWidget {
  final ImageInfoEntity imageInfo;
  final VoidCallback? onTapFavorite;
  final VoidCallback? onTapImage;

  const ImageListItem({
    Key? key,
    required this.imageInfo,
    this.onTapFavorite,
    this.onTapImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: Container(
        alignment: Alignment.topRight,
        padding: const EdgeInsets.all(1.0),
        child: IconButton(
          icon: imageInfo.isFavorite
              ? const Icon(Icons.favorite, color: Colors.red)
              : const Icon(Icons.favorite_outline, color: Colors.white),
          onPressed: () async {
            onTapFavorite?.call();
          },
        ),
      ),
      footer: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.black54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                imageInfo.displaySiteName,
                style: const TextStyle(fontSize: 12, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      child: InkWell(
        onTap: () {
          onTapImage?.call();
        },
        child: imageInfo.imageUrl.isNotEmpty
            ? CachedNetworkImage(
          imageUrl: imageInfo.imageUrl,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => const Icon(Icons.error),
        )
            : const Icon(Icons.image_not_supported),
      ),
    );
  }
}