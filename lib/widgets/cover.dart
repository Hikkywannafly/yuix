import 'package:flutter/material.dart';
import 'package:yuix/utils/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class Cover extends StatelessWidget {
  const Cover({
    super.key,
    required this.alt,
    this.url,
    this.noText = false,
    // required this.headers,
  });
  final String? url;
  final String alt;
  final bool noText;
  // final Map<String, String>? headers;
  Widget CacheNetWorkImage(BuildContext context) {
    return Center(
      child: CachedNetworkImage(
        imageUrl: 'https://via.placeholder.com/300x400.png?text=No+Image',
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[700]!,
          highlightColor: Colors.grey[200]!,
          child: Container(
            color: Colors.grey[400],
            // height: double.infinity,
          ),
        ),
        fit: BoxFit.contain,
        width: 200,
        height: 300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (url != null) {
      return CacheNetWorkImage(context);
    }

    return CacheNetWorkImage(context);
    // Container(
    //   padding: const EdgeInsets.all(8),
    //   color: ColorUtils.getColorByText(alt),
    //   child: noText
    //       ? const SizedBox.expand()
    //       : Center(
    //           child: Text(
    //             alt,
    //             style: const TextStyle(
    //               color: Colors.white,
    //             ),
    //             overflow: TextOverflow.ellipsis,
    //             maxLines: 6,
    //           ),
    //         ),
    // );
  }
}
