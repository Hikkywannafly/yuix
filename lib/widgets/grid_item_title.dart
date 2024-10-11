import 'package:flutter/material.dart';
import 'package:yuix/widgets/cover.dart';

class GridItemTitle extends StatefulWidget {
  const GridItemTitle(
      {super.key,
      required this.title,
      this.cover,
      // this.headers,
      this.onTap,
      this.subtitle});

  final String title;
  final String? cover;
  final String? subtitle;
  final Function()? onTap;
  // final Map<String, String>? headers;

  @override
  State<GridItemTitle> createState() => _GridItemTitleState();
}

class _GridItemTitleState extends State<GridItemTitle> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Cover(
            alt: widget.title,
            url: widget.cover,
            // headers: widget.headers,
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: 350,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 20,
                    child: Text(
                      'asdsad',
                      overflow: TextOverflow.ellipsis,
                      // style: const TextStyle(
                      //   color: Colors.white,
                      // ),
                    ),
                  ),
                  if (widget.subtitle != null)
                    Text(
                      widget.subtitle!,
                      overflow: TextOverflow.ellipsis,
                      // style: const TextStyle(
                      //   color: Colors.white,
                      //   fontSize: 10,
                      // ),
                    ),
                ],
              ),
            )),
        Positioned.fill(
            child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                widget.onTap?.call();
              },
            ),
          ),
        )),
      ],
    );
  }
}
