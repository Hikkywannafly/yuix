import 'package:flutter/material.dart';
import 'package:yuix/widgets/grid_item_title.dart';

class MediaItemCard extends StatefulWidget {
  const MediaItemCard({
    super.key,
    required this.title,
    required this.url,
    // required this.package,
    this.cover,
    this.update,
    // this.headers,
  });
  final String title;
  final String? cover;
  final String? update;
  final String url;
  // final String package;
  // final Map<String, String>? headers;

  @override
  State<MediaItemCard> createState() => _MediaItemCardState();
}

class _MediaItemCardState extends State<MediaItemCard> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.url,
      child: GridItemTitle(
        title: widget.title,
        cover: widget.cover,
        subtitle: widget.update,
        // headers: widget.headers,
        // onTap: () {
        //   Get.to(DetailPage(
        //     url: widget.url,
        //     package: widget.package,
        //     tag: widget.url,
        //   ));
        // },
      ),
    );
  }
}
