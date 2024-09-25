// import 'dart:math';
import 'package:yuix/models/media.dart';
// import 'package:anilist_gql/pages/detailspage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListWidget extends StatelessWidget {
  ListWidget({super.key, required this.media});
  Media media;
  @override
  // Widget build(BuildContext context) {
  //   return Text("sd");
  // }
  @override
  Widget build(BuildContext context) {
    return const InkWell(
      // onTap: (() => Get.to(() => const AnimeDetailsPage(), arguments: media)),
      child: Column(
        // margin: const EdgeInsets.symmetric(
        //   vertical: 10,
        //   horizontal: 8,
        // ),
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.black.withOpacity(0.1), width: 0.5),
        //   boxShadow: [
        //     BoxShadow(
        //         color:
        //             const Color.fromARGB(255, 161, 191, 235).withOpacity(0.2),
        //         spreadRadius: 0.1,
        //         blurRadius: 1),
        //   ],
        //   borderRadius: BorderRadius.circular(10),
        // ),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }
}
