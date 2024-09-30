// import 'dart:math';
import 'package:shimmer/shimmer.dart';
import 'package:yuix/models/media.dart';
// import 'package:anilist_gql/pages/detailspage.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

//ignore: must_be_immutable
class ListWidget extends StatelessWidget {
  ListWidget({super.key, required this.media});
  Media media;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 5.0), // Giảm khoảng cách margin
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Hero(
              tag: media.id.toString(), // Đảm bảo tag duy nhất cho mỗi hình ảnh
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
                  // width: 200,
                  height: 230,
                ),
              ),
            ),
            Positioned(
                // rating on the top right
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      Text(
                        media.averageScore.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
