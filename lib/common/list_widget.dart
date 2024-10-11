import 'package:shimmer/shimmer.dart';
import 'package:yuix/models/media.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';

class ListWidget extends StatelessWidget {
  ListWidget({
    super.key,
    required this.media,
    // required this.url,
    // required this.package
  });
  final Media media;
  // final String url;
  // final String package;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final cardWidth = screenWidth * 0.33;

    return GestureDetector(
      onTap: () {
        context.go('/detail');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Hero(
                  tag: media.id.toString(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: media.coverImage!.large.toString(),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[700]!,
                        highlightColor: Colors.grey[200]!,
                        child: Container(
                          color: Colors.grey[400],
                          height: 250,
                        ),
                      ),
                      fit: BoxFit.cover,
                      width: cardWidth,
                      height: 220,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Iconsax.star1,
                          color: Colors.yellow,
                          size: 15,
                        ),
                        Text(
                          media.averageScore!.toInt() / 10 == 0
                              ? 'N/A'
                              : (media.averageScore!.toInt() / 10).toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    media.title!.userPreferred.toString().length > 25
                        ? '${media.title!.userPreferred.toString().substring(0, screenWidth < 600 ? 10 : 25)}...' // Điều chỉnh độ dài dựa trên kích thước màn hình
                        : media.title!.userPreferred.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    media.chapters == null
                        ? '??'
                        : '${media.chapters} Chapters ',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
